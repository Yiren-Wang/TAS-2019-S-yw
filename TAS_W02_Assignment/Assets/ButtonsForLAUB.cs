using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEditor;

#if UNITY_EDITOR
using UnityEditor;
[CustomEditor(typeof(LookAtUnityBezier))]
public class ButtonsForLAUB : Editor
{
    public override void OnInspectorGUI()
    {
        LookAtUnityBezier _myLAUB =  (LookAtUnityBezier)target;
        
        DrawDefaultInspector();
        if (GUILayout.Button("Make new curve"))
        {
            _myLAUB.MakeNewCurve();
        }
        if (GUILayout.Button("Delete last curve"))
        {
            _myLAUB.DeleteLastCurve();
        }

        if (GUILayout.Button("Reconnect Curve"))
        {
            _myLAUB.ReconnectCurve();
        }
    }
}
#endif