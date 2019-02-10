using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
[RequireComponent(typeof(MeshRenderer))]
[RequireComponent(typeof(MeshFilter), typeof(MeshCollider))]
[AddComponentMenu("DCG/DCG Water")]
public class DCGWater : MonoBehaviour {

    private Vector3[] vertices;
    private MeshFilter filter;
    private MeshCollider meshCollider;

    [Header("Displacement Settings")]
    [Space()]
    public bool enableDisplacement = true;

    [Tooltip("Intensity of the displacement of the mesh.")]
    [Range(0f,15f)]
    public float noiseIntensity = 1.6f;
    [Tooltip("Tiling of the displacement noise.")]
    [Range(0.01f,0.2f)]
    public float noiseScale = 0.115f;


    [Space()]
    [Header("Physics Settings")]
    [Space()]
    public bool enableCollision = true;
    [Tooltip("Array of integers, representing the layers that will be ignored by the water, so you won't have collisions between them, by default the 'default' layer is ignored. You can add more layers if you wish.")]
    public int[] ignoreColLayers = new int[1];

    [Space()]
    public bool refreshMesh = false;

    string cachedMeshName;

    void Awake () {
        transform.tag = "Water";
        gameObject.layer = 4;
        GetData();
        for (int i = 0; i < ignoreColLayers.Length; i++)
        {
            Physics.IgnoreLayerCollision(ignoreColLayers[i], 4, true);
        }

        meshCollider.convex = false;
        GetData();
    }
	// Use this for initialization
    void GetData () {
        meshCollider = GetComponent<MeshCollider>();
        filter = GetComponent<MeshFilter>();
        meshCollider = GetComponent<MeshCollider>();
        vertices = filter.sharedMesh.vertices;
        cachedMeshName = filter.sharedMesh.name;
	}
	
	// Update is called once per frame
	void Update () {
     
        if (refreshMesh)
        {
            refreshMesh = false;
            GetData();
        }

        WaterDisplacement();
        CollisionCheck();
      
	}
    void WaterDisplacement(){
        if (vertices != null && filter != null)
        {
            if (filter.sharedMesh.name == cachedMeshName)
            {
                for (int i = 0; i < vertices.Length; i++)
                {    
                    float xCoord = (0f + Time.time) + vertices[i].x * noiseScale;
                    float yCoord = (0f + Time.time) + vertices[i].z * noiseScale;
                    vertices[i].y = (Mathf.PerlinNoise(xCoord, yCoord) - 0.5f) * noiseIntensity;
                }

                filter.sharedMesh.vertices = vertices;
                filter.sharedMesh.RecalculateBounds();
            }
            else
            {
                GetData();
            }
        }
        else
        {
            GetData();
        }
    }
    void CollisionCheck(){
        if (enableCollision)
        {
            if (meshCollider != null)
            {
                meshCollider.enabled = true;
                meshCollider.sharedMesh = null;
                meshCollider.sharedMesh = filter.sharedMesh;
            }
            else
            {
                GetData();
            }
        }
        else
        {
            if (meshCollider != null)
            {
                meshCollider.enabled = false;
            }
            else
            {
                GetData();
            }
        }
    }
}
