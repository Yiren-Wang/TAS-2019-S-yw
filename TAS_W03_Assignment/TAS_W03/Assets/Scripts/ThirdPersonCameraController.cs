using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ThirdPersonCameraController : MonoBehaviour {

    #region Internal References
    private Transform _app;
    private Transform _view;
    private Transform _cameraBaseTransform;
    private Transform _cameraPivotTransform;
    private Transform _cameraTransform;
    private Transform _cameraLookTarget;
    private Transform _avatarTransform;
    private Rigidbody _avatarRigidbody;
    private Transform _finalTarget;
    #endregion

    #region Public Tuning Variables
    public Vector3 avatarObservationOffset_Base;
    public float followDistance_Base;
    public float UpDistance_Base;
    public float DownDistance_Base;
    public float verticalOffset_Base;
    public float pitchGreaterLimit;
    public float pitchLowerLimit;
    public float fovAtUp;
    public float fovAtDown;
    #endregion

    #region Persistent Outputs
    //Positions
    private Vector3 _camRelativePostion_Auto;

    //Directions
    private Vector3 _avatarLookForward;

    //Scalars
    private float _followDistance_Applied;
    private float _verticalOffset_Applied;
    
    //state
    private CameraState _currentState;
    #endregion
    

   

    private void Start()
    {
        _currentState = CameraState.Automatic;
        _cameraBaseTransform.position = _avatarTransform.position;
    }

    private void Awake()
    {
        _app = GameObject.Find("Application").transform;
        _view = _app.Find("View");
        _cameraBaseTransform = _view.Find("CameraBase");
        _cameraPivotTransform = _cameraBaseTransform.Find("Pivot");
        _cameraTransform = _cameraPivotTransform.Find("Camera");
        _cameraLookTarget = _cameraBaseTransform.Find("CameraLookTarget");

        _avatarTransform = _view.Find("AIThirdPersonController");
        _avatarRigidbody = _avatarTransform.GetComponent<Rigidbody>();

        _finalTarget = _view.Find("FinalTarget");
    }

    private float _idleTimer = 0;

    private void Update()
    {

        if (Input.GetMouseButton(1))
        {
            _currentState = CameraState.Manual;
        }          
        else if(!Input.GetMouseButton(1) && _idleTimer >10)
        {
            _currentState = CameraState.Idle;
        }
        else
        {
            _currentState = CameraState.Automatic;
        }

        if (_currentState == CameraState.Automatic)
        {
            _AutoUpdate();
        }
        else if (_currentState == CameraState.Manual)
        {
            _ManualUpdate();
        }
        else
        {
            _IdleUpdate();
        }

        if (!_Helper_IsWalking())
        {
            _idleTimer += Time.deltaTime; 

        }
        else
        {
            _idleTimer = 0;
        }
    }

    #region States
    private void _AutoUpdate()
    {
        _ComputeData();
        _FollowAvatar();
        if (_Helper_IsThereOOI())
        {
            _LookAtObject(_Helper_WhatIsClosestOOI());
        }
        else
        {
            _LookAtAvatar();
        }
        
    }
    private void _ManualUpdate()
    {
        _FollowAvatar();
        _ManualControl();
    }

    private void _IdleUpdate()
    {
        _standingToWalkingSlider = Mathf.MoveTowards(_standingToWalkingSlider, 1, Time.deltaTime* 0.1f);
        
        float _followDistance_Walking = followDistance_Base;
        float _followDistance_Standing = UpDistance_Base; 

        float _verticalOffset_Walking = verticalOffset_Base; 
        float _verticalOffset_Standing = 45;
        
        //ease
        _followDistance_Applied = EasingFunction.EaseOutQuad(_followDistance_Standing, _followDistance_Walking,
            _standingToWalkingSlider);
        _verticalOffset_Applied = EasingFunction.EaseOutQuad(_verticalOffset_Standing, _verticalOffset_Walking,
            _standingToWalkingSlider);
        
        _cameraTransform.localPosition = Vector3.Lerp(_cameraTransform.localPosition,new Vector3(0,0,_followDistance_Applied),Time.deltaTime);
        _cameraPivotTransform.localRotation = Quaternion.Slerp(_cameraPivotTransform.localRotation,Quaternion.AngleAxis(_verticalOffset_Applied,Vector3.right),Time.deltaTime);

        
        Vector3 targetDir = Vector3.Scale(_finalTarget.position - _cameraBaseTransform.position, new Vector3(1, 0, 1));
        Quaternion _targetLookQuaternion =  Quaternion.FromToRotation(Vector3.forward, targetDir);                    
        _cameraBaseTransform.rotation = Quaternion.Slerp(_cameraBaseTransform.rotation, _targetLookQuaternion, Time.deltaTime*0.2f);      
    }
    #endregion

    #region Internal Logic

    float _standingToWalkingSlider = 0f;

    private void _ComputeData()
    {
        _avatarLookForward = Vector3.Normalize(Vector3.Scale(_avatarTransform.forward, new Vector3(1, 0, 1)));

        if (_Helper_IsWalking())
        {
            _standingToWalkingSlider = Mathf.MoveTowards(_standingToWalkingSlider, 1, Time.deltaTime * 1.5f);
        }
        else
        {
            _standingToWalkingSlider = Mathf.MoveTowards(_standingToWalkingSlider, 0, Time.deltaTime* 0.5f);
        }

        float _followDistance_Walking = followDistance_Base;
        float _followDistance_Standing = UpDistance_Base; 

        float _verticalOffset_Walking = verticalOffset_Base; 
        float _verticalOffset_Standing = 45;
        
        //ease
        _followDistance_Applied = EasingFunction.EaseInOutQuad(_followDistance_Standing, _followDistance_Walking,
            _standingToWalkingSlider);
        _verticalOffset_Applied = EasingFunction.EaseInOutQuad(_verticalOffset_Standing, _verticalOffset_Walking,
            _standingToWalkingSlider);
        
        //change camera localPosition.z
        _cameraTransform.localPosition = Vector3.Lerp(_cameraTransform.localPosition,new Vector3(0,0,_followDistance_Applied),Time.deltaTime*1.2f);
        //change pivot rotation.x
        _cameraPivotTransform.localRotation = Quaternion.Lerp(_cameraPivotTransform.localRotation,Quaternion.AngleAxis(_verticalOffset_Applied,Vector3.right),Time.deltaTime * 1.2f);
               

    }

    private void _FollowAvatar()
    {
        _camRelativePostion_Auto = _avatarTransform.position;

        _cameraLookTarget.position = _avatarTransform.position + avatarObservationOffset_Base;        
        _cameraBaseTransform.position =
            Vector3.Lerp(_cameraBaseTransform.position, _avatarTransform.position, Time.deltaTime * 2.5f);

    }

    private void _LookAtAvatar()
    {

        Quaternion _avatarLookQuaternion =  Quaternion.FromToRotation(Vector3.forward, _avatarLookForward);
        _cameraBaseTransform.rotation = Quaternion.Slerp(_cameraBaseTransform.rotation, _avatarLookQuaternion, Time.deltaTime * 0.7f);
        
    }

    private void _LookAtObject(Transform oOI)
    {
        Vector3 targetDir = Vector3.Scale(oOI.position - _cameraBaseTransform.position, new Vector3(1, 0, 1));
        Quaternion _targetLookQuaternion =  Quaternion.FromToRotation(Vector3.forward, targetDir); 

        if (Vector3.Dot(targetDir.normalized, _avatarLookForward.normalized) < -0.1f)
        {
            _targetLookQuaternion = Quaternion.FromToRotation(Vector3.forward, _avatarLookForward);
            
        }
                    
        _cameraBaseTransform.rotation = Quaternion.Slerp(_cameraBaseTransform.rotation, _targetLookQuaternion, Time.deltaTime*0.7f);      
        _cameraTransform.localPosition = Vector3.Lerp(_cameraTransform.localPosition,new Vector3(0,0,UpDistance_Base*3.8f),Time.deltaTime*1.0f);
    }
    
    private void _ManualControl()
    {
        //Vector3 _camEulerHold = _cameraTransform.localEulerAngles; 

        float rotateEulerY = _cameraBaseTransform.localEulerAngles.y;
        float rotateEulerX = _cameraPivotTransform.localEulerAngles.x; //pitch

        if (Input.GetAxis("Mouse X") != 0)
            rotateEulerY += Input.GetAxis("Mouse X");   

        if (Input.GetAxis("Mouse Y") != 0)
        {
            float temp = rotateEulerX - Input.GetAxis("Mouse Y"); 
            temp = (temp + 360) % 360;

            if (temp < 180)
                temp = Mathf.Clamp(temp, 0, pitchGreaterLimit);
            else
                temp = Mathf.Clamp(temp, 360 - pitchLowerLimit, 360);

            rotateEulerX = temp;
        }
        
        _cameraBaseTransform.localRotation = Quaternion.AngleAxis(rotateEulerY,Vector3.up);
        _cameraPivotTransform.localRotation = Quaternion.AngleAxis(rotateEulerX,Vector3.right);

        if (rotateEulerX < 180)
        {
            float cameraDistance = EasingFunction.EaseOutQuad(followDistance_Base, UpDistance_Base,
                rotateEulerX/pitchGreaterLimit);
            _cameraTransform.localPosition = new Vector3(0,0, cameraDistance);
            
        }
        if (rotateEulerX > 180)
        {
            float cameraDistance = EasingFunction.EaseInQuad(followDistance_Base, DownDistance_Base,
                (360-rotateEulerX)/pitchLowerLimit);
            _cameraTransform.localPosition = new Vector3(0,0, cameraDistance);
        }
        
        
        
        
    }
    #endregion

    #region Helper Functions

    private Vector3 _lastPos;
    private Vector3 _currentPos;
    private bool _Helper_IsWalking()
    {
        _lastPos = _currentPos;
        _currentPos = _avatarTransform.position;
        float velInst = Vector3.Distance(_lastPos, _currentPos) / Time.deltaTime;

        if (velInst > .15f)
            return true;
        else return false;
    }
    
    private bool _Helper_IsThereOOI()
    {
        Collider[] stuffInSphere = Physics.OverlapSphere(_avatarTransform.position, 7);
        
        
        
        bool _oOIPresent = false;
        for (int i = 0; i < stuffInSphere.Length; i++)
        {
            if (stuffInSphere[i].tag.Equals("ObjectsOfInterest"))
            {
                _oOIPresent = true;
            }
        }
        return _oOIPresent;
    }

    private Transform _Helper_WhatIsClosestOOI()
    {
        Collider[] stuffInSphere = Physics.OverlapSphere(_avatarTransform.position, 7);

        Transform oOITransform = transform;
        float shortDistance = 10;
        for (int i = 0; i < stuffInSphere.Length; i++)
        {
            if (stuffInSphere[i].tag.Equals("ObjectsOfInterest"))
            {
                float stuffDis = Vector3.Distance(_avatarTransform.position, stuffInSphere[i].transform.position);
                if (stuffDis < shortDistance)
                {
                    shortDistance = stuffDis;
                    oOITransform = stuffInSphere[i].transform;
                }
            }
        }
        
        
        return oOITransform;
    }

    #endregion
}

public enum CameraState{ Manual, Automatic ,Idle}
