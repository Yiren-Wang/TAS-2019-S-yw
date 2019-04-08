using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FlockManager : MonoBehaviour
{
    public GameObject[] myAutoAgentPrefab;
    

    [Range(1, 500)] public int[] numberOfSpawns;
    
    List<List<GameObject>> _allMyAgents = new List<List<GameObject>>();
    //List<GameObject> _OrangeAgents = new List<GameObject>();
    //List<GameObject> _BlueAgents = new List<GameObject>();
    //List<GameObject> _BlackAgents = new List<GameObject>();
    //Collider[] output = new Collider[11];
    // Start is called before the first frame update
    void Start()
    {
        for (int j = 0; j < numberOfSpawns.Length; j++)
        {
            List<GameObject> _sameAgents = new List<GameObject>();
            float rCube = 3 * numberOfSpawns[j] / (4 * Mathf.PI * .02f); //.02 per unit volume
            float r = Mathf.Pow(rCube, .3333333f);
        
            for (int i = 0; i < numberOfSpawns[j]; i++)
            {
                
                _sameAgents.Add(Instantiate(myAutoAgentPrefab[j], Random.insideUnitSphere * r, Quaternion.identity , transform));


            }
            _allMyAgents.Add(_sameAgents);
        }
        
        
        
    }
    
    
    
    // Update is called once per frame
    void Update()
    {
        for (int j = 0; j < numberOfSpawns.Length; j++)
        {
            foreach (var VARIABLE in _allMyAgents[j])
            {
                AutoAgent a = VARIABLE.GetComponent<AutoAgent>();
                //Physics.OverlapSphereNonAlloc(VARIABLE.transform.position, 5, output);
                Collider[] contextColliders = Physics.OverlapSphere(VARIABLE.transform.position, 5);
                List<Transform> context = new List<Transform>();
                List<Transform> obstacles = new List<Transform>();
                foreach (var c in contextColliders)
                {
                    if (c.tag.Equals("Obstacle"))
                    {
                        obstacles.Add(c.transform);
                    }
                    else if (c!= null && c.transform != a.transform && (c.GetComponent<AutoAgent>().agentColor == a.agentColor))
                    {
                        context.Add(c.transform);
                    }
                }
                a.PassArrayOfContext(context,obstacles);
            
            }
        }

        
    }
}
