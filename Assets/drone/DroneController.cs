using UnityEngine;
using System.Collections;

public class DroneController : MonoBehaviour {
	Drone drone;
	// Use this for initialization
	void Start () {
		drone = this.GetComponent<Drone> ();
	}
	
	// Update is called once per frame
	void Update () {
		if (Input.GetButton ("Ascend")) {
			drone.Ascend(Time.deltaTime * 22.0f);
				}
		if (Input.GetButton("Descend")) {
			drone.Descend(Time.deltaTime * 22.0f);
		}

		if (Input.GetAxis ("Turn") < -0.1f) {
						drone.TurnLeft (Time.deltaTime * 16.0f);
				}
		if (Input.GetAxis ("Turn") > 0.1f) {
						drone.TurnRight (Time.deltaTime * 16.0f);
				}

		if (Input.GetAxis ("Strafe") < -0.1f) {
			drone.StrafeLeft (Time.deltaTime * 16.0f);
		}
		if (Input.GetAxis ("Strafe") > 0.1f) {
			drone.StrafeRight (Time.deltaTime * 16.0f);
		}

	}
}
