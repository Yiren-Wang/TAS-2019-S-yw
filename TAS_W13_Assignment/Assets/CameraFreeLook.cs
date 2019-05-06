using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraFreeLook : MonoBehaviour
{

    public float mouseXInputSpeedScalar;
    public float mouseYInputSpeedScalar;

    private float lookYAxisAngle;
    private float lookXAxisAngle;

    void Update()
    {
        if (Input.GetAxis("Mouse X") != 0)
            lookYAxisAngle += Input.GetAxis("Mouse X") * mouseXInputSpeedScalar;
        if (Input.GetAxis("Mouse Y") != 0)
            lookXAxisAngle += Input.GetAxis("Mouse Y") * mouseYInputSpeedScalar;

        lookXAxisAngle = Mathf.Clamp(lookXAxisAngle, -60, 60);
        lookYAxisAngle = (lookYAxisAngle + 360) % 360;

        Debug.Log(lookXAxisAngle + " " + lookYAxisAngle);

        transform.rotation = Quaternion.Euler(lookXAxisAngle, lookYAxisAngle, 0);
    }
}
