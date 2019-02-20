using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DotProductCalc : MonoBehaviour
{


    public Vector3 v1Start;
    public Vector3 v1End;
    
    public Vector3 v2Start;
    public Vector3 v2End;

    private Vector3 _v1;
    private Vector3 _v2;
    
    public float outputOfDotProduct1 { get; private set; }
    public float outputOfDotProduct2 { get; private set; }
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        Debug.DrawLine(v1Start,v1End);
        Debug.DrawLine(v2Start,v2End);

        _v1 = v1End - v1Start;
        _v2 = v2End - v2Start;
        _v1 = Vector3.Normalize(_v1);
        _v2 = Vector3.Normalize(_v2);
        outputOfDotProduct1 = Vector3.Dot(_v1, _v2);
        outputOfDotProduct2 = Vector3.Dot(_v2, _v1);
    }
}
