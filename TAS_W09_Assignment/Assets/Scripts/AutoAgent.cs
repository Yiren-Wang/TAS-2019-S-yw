using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class AutoAgent : MonoBehaviour
{
    public int agentColor;
    public Vector3 moveDirection;
    public float smoothStrength = 0.01f;
    public float moveVelocityMagnitude;

    public Transform myModelTranform;
    public Renderer rend;
    public float avoidRadius = 0.5f;
    [Range(0.0f, 1.0f)] public float ClumpStrength;
    [Range(0.0f, 1.0f)] public float AlignStrength;
    [Range(0.0f, 1.0f)] public float AvoidStrength;
    [Range(0.0f, 1.0f)] public float OriginStrength;
    // Start is called before the first frame update
    void Start()
    {
        //layerMask = ~layerMask;
        moveDirection = Vector3.Normalize(Random.insideUnitSphere);
        myModelTranform = transform.GetChild(0);
    }


    void MoveInMyAssignedDirection(Vector3 direction, float magnitude)
    {
        transform.position += direction * magnitude * Time.deltaTime;
        
        myModelTranform.rotation = Quaternion.LookRotation(direction);

    }

    public void PassArrayOfContext( List<Transform> context , List<Transform> Obstacles)
    {
        if (rend != null)
        {
            foreach (var mat in rend.materials)
            {
                mat.SetFloat("_Opacity", 0.5f + 0.4f*Mathf.Sin(Time.time * 0.9f));
            }
        }
        CalcMyDir(context, Obstacles);
        MoveInMyAssignedDirection(moveDirection, moveVelocityMagnitude);
    }

    Vector3 ClumpDir(List<Transform> context)
    {
        Vector3 midpoint = Vector3.zero;
        foreach (var VARIABLE in context)
        {
            midpoint += VARIABLE.transform.position;
        }

        midpoint /= context.Count;

        Vector3 dirIWantToGo = midpoint - transform.position;
        Vector3 normalizedDirIWantto = Vector3.Normalize(dirIWantToGo);
        //Vector3 curVelocity = moveDirection * moveVelocityMagnitude;
        normalizedDirIWantto =
            Vector3.SmoothDamp(transform.GetChild(0).forward, normalizedDirIWantto, ref moveDirection, smoothStrength);
        return normalizedDirIWantto;
    }


    Vector3 Align(List<Transform> context)
    {
        Vector3 headings = Vector3.zero;
        foreach (var c in context)
        {
            headings += c.transform.GetChild(0).forward;
        }

        headings /= context.Count();

        return Vector3.Normalize(headings);

    }

    Vector3 Avoidance(List<Transform> context, List<Transform> Obstacles)
    {
        
        Vector3 avoidDir = Vector3.zero;
        int nAvoid = 0;
        foreach (var VARIABLE in context)
        {
            if (Vector3.Distance(VARIABLE.position, transform.position) < avoidRadius)
            {
                nAvoid++;
                avoidDir += transform.position - VARIABLE.position;
            }
        }
        foreach (var o in Obstacles)
        {
                nAvoid++;
                avoidDir += transform.position - o.position;
        }

        avoidDir /= nAvoid;

        Vector3 normalizedAvoidDir = Vector3.Normalize(avoidDir);
        return normalizedAvoidDir;
    }
    
    Vector3 MoveTowardOrigin()
    {
        return Vector3.zero - transform.position;

    }
    public void CalcMyDir(List<Transform> context, List<Transform> Obstacles)
    {
        moveDirection = Vector3.Lerp(moveDirection,
            Vector3.Normalize(ClumpDir(context) * ClumpStrength + 
                              Align(context) * AlignStrength+ 
                              Avoidance(context,Obstacles) *AvoidStrength + 
                              MoveTowardOrigin() * OriginStrength * Vector3.Magnitude(transform.position) /500),
            .05f);

    }
   

   
}
