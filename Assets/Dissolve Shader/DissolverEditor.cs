using UnityEngine;
using UnityEditor;

[CustomEditor(typeof(Dissolver))]
public class DissolverEditor : Editor
{
    public override void OnInspectorGUI() {
        DrawDefaultInspector();
        Dissolver dissolver = (Dissolver)target;
        if(Application.isPlaying){
            if(GUILayout.Button("Dissolve")){
                dissolver.Dissolve();
            }
            if(GUILayout.Button("Appear")){
                dissolver.Appear();
            }
        }
    }
}
