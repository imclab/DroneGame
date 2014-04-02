using UnityEngine;
using System.Collections;

public class Drone : MonoBehaviour {
	public float hover_height = 9.81f;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {

	}

	void FixedUpdate()
	{

	}

	public void Ascend(float amount)
	{
		this.rigidbody.AddForce (0.0f, amount, 0.0f, ForceMode.Acceleration);
	}

	public void Descend(float amount)
	{
		this.rigidbody.AddForce (0.0f, -amount, 0.0f, ForceMode.Acceleration);
	}

	public void TurnLeft(float amount)
	{
		this.rigidbody.AddTorque (0.0f, -amount, 0.0f, ForceMode.Acceleration);
	}

	public void TurnRight(float amount)
	{
		this.rigidbody.AddTorque (0.0f, amount, 0.0f, ForceMode.Acceleration);
	}


	public void StrafeLeft(float amount)
	{
		this.rigidbody.AddTorque (-amount, 0.0f, 0.0f, ForceMode.Acceleration);
	}
	
	public void StrafeRight(float amount)
	{
		this.rigidbody.AddTorque (amount, 0.0f, 0.0f, ForceMode.Acceleration);
	}

}
