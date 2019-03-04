using System.Collections;
using System.Collections.Generic;
using System.Dynamic;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;

public class ChunkExample : MonoBehaviour
{
    #region Mesh Generate Variables
    private Vector3[] _verts;
    private int[] _tris;
    private Vector3[] _normals;
    private Vector2[] _uVs;
    #endregion

    #region Public Tuning Variables
    private int sizeSquare; //with edges
    public int meshSquare; //no edges
    public int octaves;  //many octaves add together will make the mesh have more details
    [Range(0,1)]
    public float persistance; //control decrease in amplitude of octaves (<1)
    public float lacunarity; //control increase in frequency of octaves (>1)
    public int seed; //random seed
    public float heightMultiplier; //adjust the height range
    public AnimationCurve MeshHeightCurve; //make the lower part flat
    #endregion
    
    #region Private Output Variables
    private int _totalVertInd;
    private int _totalTrisInd;
    private float[,] _noizeMap;
    private int[,] vertsBorderMap;
    private int _meshIndex;
    private int _borderIndex;
    private Vector3[] borderVertices;
    private int[] borderTris;   
    private int triangleIndex;
    private int borderTriangleIndex;
    #endregion
    
    #region Mesh Calculate Functions
    
    // init all the mesh attribute arrays
    private void _Init() 
    {
        sizeSquare = meshSquare + 2;
        _totalVertInd = (meshSquare+ 1) *(meshSquare + 1);
        _totalTrisInd = (meshSquare) * (meshSquare) * 2 * 3;
        _verts = new Vector3[_totalVertInd];
        _tris = new int[_totalTrisInd];
        _uVs = new Vector2[_totalVertInd];
        _normals = new Vector3[_totalVertInd];
        
        vertsBorderMap = new int[sizeSquare + 1, sizeSquare + 1];
        borderVertices = new Vector3[sizeSquare *4];
        borderTris = new int[sizeSquare * 24 - 24];
        
        _meshIndex = 0;
        _borderIndex = -1;
        triangleIndex = 0;
        borderTriangleIndex = 0;

    }

    private void _CalcMesh()
    {
        for (int z = 0; z < sizeSquare + 1; z++)
        {
            for (int x = 0; x < sizeSquare +1; x++)
            {
                Vector3 vertPos = new Vector3(x,heightMultiplier * MeshHeightCurve.Evaluate(_noizeMap[x,z]), z);
                int borderIndex = vertsBorderMap[x, z];
                if (borderIndex < 0)
                {
                    borderVertices[-borderIndex - 1] = vertPos;
                }
                else
                {
                    _verts[borderIndex] = vertPos;
                }
            }
        }


        for (int i = 0; i < sizeSquare; i++)
        {
            for (int j = 0; j < sizeSquare ; j++)
            {
                int bottomLeft = vertsBorderMap[i,j];
                int bottomRight = vertsBorderMap[i+1,j];
                int upperLeft = vertsBorderMap[i,j+1];
                int upperRight = vertsBorderMap[i+1,j+1];
                
                
                _AddTris(bottomLeft,upperLeft,bottomRight);
                _AddTris(bottomRight,upperLeft,upperRight);
            }
        }
    }
  
    private void _SetVertBorderIndex()
    {
        for (int z = 0; z < sizeSquare+1; z++)
        {
            for (int x = 0; x < sizeSquare+1; x++)
            {
                bool isBorderVertex = (z == 0 || z == sizeSquare || x == 0 || x == sizeSquare);
                if (isBorderVertex)
                {
                    vertsBorderMap[x, z] = _borderIndex;
                    _borderIndex--;
                }
                else
                {
                    vertsBorderMap[x, z] = _meshIndex;
                    _meshIndex++;
                }
            }
        }
    }   
    
    private void _CalcNoiseMap(Vector2 position)
    {
        
        _noizeMap = new float[sizeSquare+1,sizeSquare+1];
        
        System.Random randomFromSeed = new System.Random(seed);
        Vector2[] octaveOffsets = new Vector2[octaves];
        float maxPossibleHeight = 0;
        float amplitude = 1;
        float frequency = 1;
        for (int i = 0; i < octaves; i++)
        {
            float offsetX = randomFromSeed.Next(-10000, 10000);
            float offsetY = randomFromSeed.Next(-10000, 10000);
            octaveOffsets[i]= new Vector2(offsetX,offsetY);

            maxPossibleHeight += amplitude;
            amplitude *= persistance;
        }
        
        float maxNoiseHeight = float.MinValue;
        float minNoiseHeight = float.MaxValue;
        
        for (int z = 0; z < sizeSquare + 1; z++)
        {
            for (int x = 0; x < sizeSquare +1; x++)
            {
                amplitude = 1;
                frequency = 1;
                float noiseHeight = 0;
                for (int o = 0; o < octaves; o++)
                {
                    float sampleX = ((float) x + position.x+ octaveOffsets[o].x) / 10 * frequency ;
                    float sampleZ = ((float) z + position.y+ octaveOffsets[o].y) / 10 * frequency ;

                    float perLinValue = Perlin.Noise(sampleX, sampleZ) * 2 - 1; //>0
                    noiseHeight += perLinValue * amplitude;

                    amplitude *= persistance;  //decrease
                    frequency *= lacunarity;   //increase

                }
                
                if (noiseHeight > maxNoiseHeight)
                {
                    maxNoiseHeight = noiseHeight;
                }
                else if(noiseHeight<minNoiseHeight)
                {
                    minNoiseHeight = noiseHeight;
                }

                _noizeMap[x, z] = noiseHeight;
                

            }
        }

        for (int z = 0; z < sizeSquare + 1; z++)
        {
            for (int x = 0; x < sizeSquare + 1; x++)
            {
                //_noizeMap[x, z] = Mathf.InverseLerp(minNoiseHeight, maxNoiseHeight, _noizeMap[x, z]);
                float normalizedHeight = (_noizeMap[x, z] +1f) / (maxPossibleHeight/0.9f);
                _noizeMap[x, z] = normalizedHeight;

            }
        }

    }
    
    private void _CalcNormals()
    {
        int trisCount = _tris.Length / 3;
        for (int i = 0; i < trisCount; i++)
        {
            int normalTriangleInd = i * 3;
            int vertA = _tris[normalTriangleInd];
            int vertB = _tris[normalTriangleInd + 1];
            int vertC = _tris[normalTriangleInd + 2];
            
            Vector3 triNormal = _CalcfaceNormal(vertA, vertB, vertC);
            _normals[vertA] += triNormal;
            _normals[vertB] += triNormal;
            _normals[vertC] += triNormal;
        }
        int borderTrisCount = borderTris.Length/ 3;
        for (int i = 0; i < borderTrisCount; i++)
        {
            int normalTriangleInd = i * 3;
            int vertA = borderTris[normalTriangleInd];
            int vertB = borderTris[normalTriangleInd + 1];
            int vertC = borderTris[normalTriangleInd + 2];
            
            Vector3 triNormal = _CalcfaceNormal(vertA, vertB, vertC);
            if (vertA > 0)
            {
                _normals[vertA] += triNormal;
            }
            if (vertB > 0)
            {
                _normals[vertB] += triNormal;
            }
            if (vertC > 0)
            {
                _normals[vertC] += triNormal;
            }
        }

        for (int i = 0; i < _normals.Length; i++)
        {
            _normals[i].Normalize();
        }
    }
    #endregion
    
    #region Public Mesh Generate Function
    public GameObject GenerateNewChunk(Vector2 position)
    {
        GameObject chunkGameObject = new GameObject("chunk");
        MeshFilter _myMF = chunkGameObject .AddComponent<MeshFilter>();
        MeshRenderer _myMR = chunkGameObject .AddComponent<MeshRenderer>();

        Mesh chunkMesh = new Mesh();
        
        _Init();
        _SetVertBorderIndex();
        _CalcNoiseMap(position);
        _CalcMesh();
        _CalcNormals();
        chunkMesh.vertices = _verts;
        chunkMesh.triangles = _tris;
        chunkMesh.normals = _normals;

        _myMF.mesh = chunkMesh;
        _myMR.material = Resources.Load<Material>("MyMat");


        return chunkGameObject;
    }
    #endregion

    #region Helper Functions
    private void _AddTris(int a,int b,int c)
    {
       
        if (a < 0 || b < 0 || c < 0) {
            borderTris [borderTriangleIndex] = a;
            borderTris [borderTriangleIndex + 1] = b;
            borderTris [borderTriangleIndex + 2] = c;
            borderTriangleIndex += 3;
        } else {
            _tris [triangleIndex] = a;
            _tris [triangleIndex + 1] = b;
            _tris [triangleIndex + 2] = c;
            triangleIndex += 3;
        }
    }


    Vector3 _CalcfaceNormal(int indexA, int indexB, int indexC)
    {
        Vector3 pointA = (indexA < 0)?borderVertices[-indexA-1] : _verts [indexA];
        Vector3 pointB = (indexB < 0)?borderVertices[-indexB-1] : _verts [indexB];
        Vector3 pointC = (indexC < 0)?borderVertices[-indexC-1] : _verts [indexC];

        Vector3 sideAB = pointB - pointA;
        Vector3 sideAC = pointC - pointA;
        return Vector3.Cross (sideAB, sideAC).normalized;
    }
    
    #endregion
}
