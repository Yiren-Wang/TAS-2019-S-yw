using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CubeTreadmill : MonoBehaviour
{
    #region Public Tuning Variables
    public Transform target;
    #endregion
    
    #region Private Output Variables   
    private int chunkSize;
    private int chunkVisibleInViewDis;      
    private Vector2 viewerPositionOld;
    private Dictionary<Vector2, TerrainChunk> chunksDictionary = new Dictionary<Vector2, TerrainChunk>();
    private List<TerrainChunk> chunksVisibleLastUpdate = new List<TerrainChunk>();
    #endregion

    #region Static Variables
    private const float maxViewDistance = 200;  //camera visible range
    private static Vector2 viewerPosition;      //camera position
    private static ChunkExample _chunkExample;
    private const float viewerMoveThreshold = 25f;  //update visible chunks when camera move distance > 25
    private const float sqrViewerMoveThreshold = viewerMoveThreshold * viewerMoveThreshold; 
    #endregion
    

    void Start()
    {
        _chunkExample = GetComponent<ChunkExample>();
        chunkSize = _chunkExample.meshSquare;
        chunkVisibleInViewDis = Mathf.RoundToInt(maxViewDistance / chunkSize); 
        viewerPositionOld = new Vector2(float.MinValue,float.MinValue);
        viewerPosition = new Vector2 (target.position.x, target.position.z);
        
        UpdateVisibleChunks ();        
    }

    // Update is called once per frame
    void Update()
    {
        //update camera position
        viewerPosition = new Vector2 (target.position.x, target.position.z);   
        //update chunks
        if ((viewerPositionOld - viewerPosition).sqrMagnitude > sqrViewerMoveThreshold) {
            viewerPositionOld = viewerPosition;
            UpdateVisibleChunks ();
        }
        
    }
    #region Helper Functions
    void UpdateVisibleChunks() 
    {
        //clear the visible chunks list
        for (int i = 0; i < chunksVisibleLastUpdate.Count; i++) {
            chunksVisibleLastUpdate [i].SetVisible (false);
        }
        chunksVisibleLastUpdate.Clear ();
        
        //calculate camera position
        int curChunkCoodX = Mathf.RoundToInt(viewerPosition.x / chunkSize);
        int curChunkCoodY =  Mathf.RoundToInt(viewerPosition.y / chunkSize);

        //check chunks around camera
        for (int yOffset = -chunkVisibleInViewDis; yOffset<=chunkVisibleInViewDis; yOffset++) 
        {
            for (int xOffset = -chunkVisibleInViewDis; xOffset <= chunkVisibleInViewDis; xOffset++)
            {
                Vector2 viewedChunkCoord = new Vector2(curChunkCoodX + xOffset, curChunkCoodY + yOffset); //chunk position 
                
                //if this chunk has been created, it can be found in the dictionary
                if (chunksDictionary.ContainsKey(viewedChunkCoord))  
                {
                    chunksDictionary[viewedChunkCoord].UpdateTerrainChunk();  //update visible
                    if (chunksDictionary[viewedChunkCoord].IsVisible())       
                    {
                        chunksVisibleLastUpdate.Add(chunksDictionary[viewedChunkCoord]);  //put it into visible list
                    }
                }
                else
                {
                    //if this chunk has not been created, then create it and put it into dictionary
                    chunksDictionary.Add(viewedChunkCoord, new TerrainChunk(viewedChunkCoord, chunkSize, transform)); 
                }

            }
        }
    }
    #endregion
    
    public class TerrainChunk {

        #region Chunk Variables
        GameObject meshObject;
        Vector2 position;
        Bounds bounds;
        #endregion

        #region New Chunk Create Function
        public TerrainChunk(Vector2 coord, int size, Transform parent) {
            position = coord * size;
            bounds = new Bounds(position,Vector2.one * size);
            Vector3 positionV3 = new Vector3(position.x,0,position.y);

            meshObject = _chunkExample.GenerateNewChunk(position);
            meshObject.transform.position = positionV3;
            meshObject.transform.parent = parent;
            SetVisible(false);
        }        
        #endregion
        

        #region New Chunk Update Function
        public void UpdateTerrainChunk() {
            float viewerDstFromNearestEdge = Mathf.Sqrt(bounds.SqrDistance (viewerPosition)); //use distance to decide whether it is visible
            bool visible = viewerDstFromNearestEdge <= maxViewDistance;
            SetVisible (visible);
        }

        public void SetVisible(bool visible) {
            meshObject.SetActive (visible);
        }

        public bool IsVisible() {
            return meshObject.activeSelf;
        }
        #endregion
    }

    
}

