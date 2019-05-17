using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RandomGlitching : MonoBehaviour
{
    public float maxTimeBetweenGlitches = 3f;
    public float glitchDuration = 0.5f;

    Material mat;
    // Start is called before the first frame update
    void Start()
    {
        mat = GetComponent<Renderer>().material;
        StartCoroutine(RandomGlitch());
    }

    IEnumerator RandomGlitch(){
        while(true){
            float interval = Random.Range(1, maxTimeBetweenGlitches);
            yield return new WaitForSeconds(interval);
            mat.SetFloat("_GlitchLevel", 1);
            yield return new WaitForSeconds(glitchDuration);
            mat.SetFloat("_GlitchLevel", 0);
        }
    }

}
