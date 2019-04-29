using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraWalk : MonoBehaviour
{
    Ray inFront;
    Ray inBack;

    public float baseWalkSpeed;
    public LayerMask walkRayLayerMask;

    private float _appliedWalkSpeed;
    private RaycastHit _myWalkingRayHit;

    void Update()
    {
        if (Input.GetKey(KeyCode.LeftShift))
            _appliedWalkSpeed = 2 * baseWalkSpeed;
        else
            _appliedWalkSpeed = baseWalkSpeed;

        if (Input.GetMouseButton(0))
        {
            inFront.origin = transform.position + transform.forward * _appliedWalkSpeed * Time.deltaTime + Vector3.up * 1000;
            inFront.direction = Vector3.down;
            Physics.Raycast(inFront, out _myWalkingRayHit, Mathf.Infinity, walkRayLayerMask, QueryTriggerInteraction.Ignore);
            if (_myWalkingRayHit.collider != null)
            {
                transform.position = _myWalkingRayHit.point + Vector3.up * 1.8f;
            }
        }
        if (Input.GetMouseButton(1))
        {
            inBack.origin = transform.position - transform.forward * _appliedWalkSpeed * Time.deltaTime + Vector3.up * 1000;
            inBack.direction = Vector3.down;
            Physics.Raycast(inBack, out _myWalkingRayHit, Mathf.Infinity, walkRayLayerMask, QueryTriggerInteraction.Ignore);
            if (_myWalkingRayHit.collider != null)
            {
                transform.position = _myWalkingRayHit.point + Vector3.up * 1.8f;
            }
        }
    }
}
