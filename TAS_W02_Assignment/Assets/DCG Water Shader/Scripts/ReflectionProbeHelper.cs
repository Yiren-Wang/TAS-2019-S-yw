using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class ReflectionProbeHelper : MonoBehaviour {

public bool enableHelper;

    Transform cam;
    public Transform waterTransform;

	// Update is called once per frame
	void Update () {

        if (!cam)
        {
            cam = Camera.main.transform;
        }

        if (enableHelper)
        {
            if (cam && waterTransform)
            {

                float heightDiff = cam.position.y - waterTransform.position.y;

                Vector3 tempVect = new Vector3(
                    cam.position.x, 
                    waterTransform.position.y - heightDiff,
                    cam.position.z);
                transform.position = tempVect;
            }
        }
	}
}
