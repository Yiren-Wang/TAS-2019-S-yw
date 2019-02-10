using UnityEngine;
[AddComponentMenu("DCG/Water Cutout Mask")]
public class WaterCutoutMask : MonoBehaviour {

    protected int[] queueOrder = new int[]{2550};

    protected void Awake() {
        Material[] materials = GetComponent<Renderer>().materials;
        for (int i = 0; i < materials.Length && i < queueOrder.Length; ++i) {
            materials[i].renderQueue = queueOrder[i];
        }
    }
}