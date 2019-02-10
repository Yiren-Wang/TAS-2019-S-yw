using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using UnityEditor;
using UnityEngine;

#if UNITY_EDITOR
using UnityEditor;
#endif

//[ExecuteInEditMode] 
public class LookAtUnityBezier : MonoBehaviour
{
    [Header("Public References")] 
    public GameObject camera;
    public float moveSpeed;
    [Header("My List of Curves")]
    public List<BezierExample> curveList = new List<BezierExample>();

    public Transform myModel;

    private float percentOnCurve;
    private int indexOfCurCurve;
    private float disPerDeltaTime;
    private float percentPerDeltaTime;
    private Vector3 lastPosition;
    
    

    // Start is called before the first frame update
    void Start()
    {
        indexOfCurCurve = 0;
        disPerDeltaTime = moveSpeed * Time.fixedDeltaTime; //set the move distance in every deltatime 
        percentPerDeltaTime = disPerDeltaTime / CurveLength(curveList[0]); 
        lastPosition = Vector3.back;
        percentOnCurve = 0;

    }

    /*private void _PutPointsOnCurve()
    {
        //Run through 100 points, and place a marker at those points on the bezier curve
        //1: for loop through 100 points between 0 and 1
        //2: pass that fraction to a curve calc to find the resultant v3
        //3:place a marker at that v3
        for (int i = 0; i <= 100; i++)
        {
            float t = (float) i / 100;
            Vector3 pointOnCurve = CalculateBezier(bezEx, t);
            Instantiate(marker, pointOnCurve, Quaternion.identity, null);
        }
    }*/

    Vector3 CalculateBezier(BezierExample curveData, float t)
    {
        Vector3 a = curveData.startPoint;
        Vector3 b = curveData.startTangent;
        
        Vector3 c = curveData.endTangent;
        Vector3 d= curveData.endPoint;
        Vector3 ab = Vector3.Lerp(a, b, t);
        Vector3 bc = Vector3.Lerp(b, c, t);
        Vector3 cd = Vector3.Lerp(c, d, t);

        Vector3 abc = Vector3.Lerp(ab, bc, t);
        Vector3 bcd = Vector3.Lerp(bc, cd, t);
        
        Vector3 final = Vector3.Lerp(abc, bcd, t);
        return final;
    }

    public void MakeNewCurve()
    {
        BezierExample newBE = myModel.gameObject.AddComponent<BezierExample>();
        
        if (curveList.Count > 0)
        {
            BezierExample lastBE = curveList[curveList.Count - 1];
            newBE.startPoint = lastBE.endPoint;
            newBE.endPoint = lastBE.endPoint + Vector3.forward;
            newBE.startTangent = newBE.startPoint - (lastBE.endTangent - lastBE.endPoint);
            newBE.endTangent = newBE.endPoint - Vector3.forward / 2;
        }            
        curveList.Add(newBE);
    }

    public void DeleteLastCurve()
    {
        if (curveList.Count > 1)
        {
            BezierExample lastCurve = curveList.Last();
            curveList.Remove(curveList.Last());
            DestroyImmediate(lastCurve);
        }
        
    }

    public void ReconnectCurve()
    {
        for (int i = 1; i < curveList.Count; i++)
        {
            
            curveList[i].startPoint = curveList[i-1].endPoint;
            curveList[i].startTangent = curveList[i].startPoint - (curveList[i-1].endTangent - curveList[i-1].endPoint);
        }
    }
    float CurveLength(BezierExample curveData)
    {
        float length = 0;
        for (int i = 0; i < 100; i++)
        {
            length += Vector3.Distance(CalculateBezier(curveData, (float) i / 100),
                CalculateBezier(curveData, (float) (i + 1) / 100));
        }

        return length;
    }
    
    
    // Update is called once per frame
    void FixedUpdate()
    {       
        
        if (percentOnCurve < 1)
        {
            camera.transform.position = (CalculateBezier(curveList[indexOfCurCurve], percentOnCurve));
            
            
        }
        else
        {
            indexOfCurCurve++;
            if (indexOfCurCurve >= curveList.Count)
            {
                indexOfCurCurve = 0;
            }
            percentOnCurve = 0;
            percentPerDeltaTime = disPerDeltaTime / CurveLength(curveList[indexOfCurCurve]);   //set the move percentage in per deltatime on this new curve
            camera.transform.position = (CalculateBezier(curveList[indexOfCurCurve], percentOnCurve));
        }

        percentOnCurve += percentPerDeltaTime;
        camera.transform.rotation = Quaternion.Lerp(camera.transform.rotation,Quaternion.LookRotation(camera.transform.position-lastPosition, Vector3.up),0.04f);
        lastPosition = camera.transform.position;



    }
}


