using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ApplyPostProcessing : MonoBehaviour
{
    public Material mat;

    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        // Copy the source Render Texture to the destination,
        // applying the material along the way.
        Graphics.Blit(src, dest, mat);
    }
}
