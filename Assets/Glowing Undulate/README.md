# GLOWING UNDULATION

Glows and undulates.

[screenshot](https://github.com/dominguerilla/shader-studies/blob/master/Assets/Glowing Undulate/glowing_undulate_001.gif)

For emissive materials to cast light on objects, the emissive object has to be static.
When I made the emissive objects static, it had this odd effect where the vertexes undulated as expected in the editor, but in Play mode they would undulate back and forth away from a certain point...
	
	- this was fixed by adding the tag "DisableBatching" = "True" to the shader
	
	- https://answers.unity.com/questions/1325005/why-does-my-vertex-animation-shader-produce-differ.html
	
	- gotta look into those later
	
	- also, gotta get the emissive light casting working; it doesn't look like it's affecting the floor
