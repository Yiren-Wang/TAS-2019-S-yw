using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AnimatorParameterControl : MonoBehaviour
{
    private float walk_Blend_X;
    private float walk_Blend_Y;

    private float time;

    private Animator _myAnimator;
    private float IdleTime;
    [Header("Tuning Values")] 
    [Range(0.001f, 10.0f)] public float walkCycleTime; 
    [Range(0.0f, 1.0f)] public float walkRunMagnitude;

    [Range(0.001f, 1.0f)] public float walkRunBlendTotal;
    // Start is called before the first frame update
    void Start()
    {
        _myAnimator = GetComponent<Animator>();
    }
    //Soh - opposite / hypotenuse
    //Cah - adjacent / hypotenuse
    //Toa - opposite / adjacent

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKey(KeyCode.W))
        {
            _myAnimator.SetBool("Idle_False_Move_True",true);
        }
        else
        {
            _myAnimator.SetBool("Idle_False_Move_True",false);
        }

        IdleTime += Time.deltaTime * 4;
        _myAnimator.SetFloat("Idle_TreeVal_X", (1 + Mathf.Sin(IdleTime)) /2);
        walkCycleTime = 1 - (0.5f * walkRunBlendTotal) ;
        walkRunMagnitude = .25f + (.75f * walkRunBlendTotal);
        time += (Mathf.PI * 2 * Time.deltaTime) / walkCycleTime;
        walk_Blend_X = Mathf.Cos(time) * walkRunMagnitude;
        walk_Blend_Y = Mathf.Sin(time) *walkRunMagnitude;
        _myAnimator.SetFloat("Walk_TreeVal_X",walk_Blend_X);
        _myAnimator.SetFloat("Walk_TreeVal_Y",walk_Blend_Y);
    }
}
