using UnityEngine;
using System.Collections;

public class OrbitCamera : MonoBehaviour {

public Transform target;
    public float distance = 5.0f;
    public float xSpeed = 120.0f;
    public float ySpeed = 120.0f;
 
    public float yMinLimit = -20f;
    public float yMaxLimit = 80f;
 
    public float distanceMin = .5f;
    public float distanceMax = 15f;
 
	public Vector3 offset;

	public Texture2D crosshair_tex;
	Rect crosshair_position;
	public float crosshair_size = 16.0f;

	public Transform proj;
    float x = 0.0f;
    float y = 0.0f;
 
	// Use this for initialization
	void Start () {
        Vector3 angles = transform.eulerAngles;
        x = angles.y;
        y = angles.x;
 
        // Make the rigid body not change rotation
        if (rigidbody)
            rigidbody.freezeRotation = true;
	}
 
	void Update()
	{
		Vector3 adjusted_target_position = target.position + target.TransformDirection(offset);
		Vector3 fwd = transform.TransformDirection(Vector3.forward) * 20.0f;
		
		//Debug.DrawRay (transform.position, fwd, Color.red, 40.0f);


		RaycastHit hit;

	if (Physics.Linecast (adjusted_target_position, fwd, out hit, ~(1 << 8))) {
		//crosshair_position = new Rect ((Screen.width - crosshair_size) / 2, (Screen.height - crosshair_size) / 2, crosshair_size, crosshair_size);
		Vector3 screen_point = camera.WorldToScreenPoint (hit.point);
		Vector2 gui_point = GUIUtility.ScreenToGUIPoint(screen_point);
			Debug.Log (screen_point);
			Debug.Log (gui_point);


		crosshair_position = new Rect (screen_point.x - (crosshair_size/2), Screen.height - screen_point.y - (crosshair_size/2), crosshair_size, crosshair_size);

	
		if (Input.GetKeyUp (KeyCode.A)) {
				Debug.Log(hit.point.x + ", " + hit.point.y + ", " + hit.point.z);
				Debug.DrawLine(target.position, hit.point, Color.blue, 10.0f);
				Debug.DrawLine(transform.position, hit.point, Color.white, 10.0f);
				//Debug.Break();
				//Instantiate(proj, hit.point, Quaternion.identity);
			}
	}

	}

    void LateUpdate () {
    if (target) {
			Vector3 adjusted_target_position = target.position + target.TransformDirection(offset);

        //x += Input.GetAxis("Mouse X") * xSpeed * distance * 0.02f;
        //y -= Input.GetAxis("Mouse Y") * ySpeed * 0.02f;
 

        y = ClampAngle(y, yMinLimit, yMaxLimit);
 
			Quaternion rotation = target.transform.rotation * Quaternion.Euler(y, x, 0);
 
        distance = Mathf.Clamp(distance - Input.GetAxis("Mouse ScrollWheel")*5, distanceMin, distanceMax);
 
        RaycastHit hit;
			if (Physics.Linecast (target.position, adjusted_target_position, out hit)) {
				//distance -=  hit.distance;
        }

		Vector3 negDistance = new Vector3(0.0f, 0.0f, -distance);
			Vector3 position = rotation * negDistance + adjusted_target_position;
 
        transform.rotation = rotation;
        transform.position = position;
 
    }
 
}

	public void OnGUI()
	{
		GUI.DrawTexture (crosshair_position, crosshair_tex);

		}
 
    public static float ClampAngle(float angle, float min, float max)
    {
        if (angle < -360F)
            angle += 360F;
        if (angle > 360F)
            angle -= 360F;
        return Mathf.Clamp(angle, min, max);
    }
}
