using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DragParticle : MonoBehaviour
{
    private Vector3 particleScreenSpace;
    private Vector3 particleWorldSpace;
    private Vector3 mouseScreenSpace;


    void OnMouseDrag()

    {
        particleScreenSpace = Camera.main.WorldToScreenPoint(transform.position);
        mouseScreenSpace = new Vector3(Input.mousePosition.x, Input.mousePosition.y, particleScreenSpace.z);
        particleWorldSpace = Camera.main.ScreenToWorldPoint(mouseScreenSpace);
        transform.position = particleWorldSpace;
    }

}