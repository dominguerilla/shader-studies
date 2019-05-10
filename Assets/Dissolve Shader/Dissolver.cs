using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Dissolver : MonoBehaviour
{
    public float speed = 1f;
    public bool autoDissolve = false;
    Renderer rend;

    // Start is called before the first frame update
    void Start()
    {
        rend = GetComponent<Renderer>();
    }

    // Update is called once per frame
    void Update()
    {
        if(autoDissolve){
            float dissolution = Mathf.PingPong(Time.time * speed, 1.0f);
            rend.material.SetFloat("_SliceAmount", dissolution);
        }
    }

    public void Dissolve(){
        StartCoroutine(StartDissolve());
    }

    public void Appear(){
        StartCoroutine(StartAppear());
    }

    IEnumerator StartDissolve(){
        // what an obtuse fuckin name
        float ephemerality = 0.0f;
        do{
            ephemerality += 0.01f * speed;
            rend.material.SetFloat("_SliceAmount", ephemerality);
            yield return new WaitForEndOfFrame();
        }while(ephemerality < 1.0f);
        
    }

    IEnumerator StartAppear(){
        float ephemerality = 1.0f;
        do{
            ephemerality -= 0.01f * speed;
            rend.material.SetFloat("_SliceAmount", ephemerality);
            yield return new WaitForEndOfFrame();
        }while(ephemerality > 0.0f);
    }
}
