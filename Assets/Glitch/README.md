# GLITCH VERTEX SHADER

Displaces the vertices of a mesh in a 'glitch'-like manner given a sample texture.

![Before](Assets/Glitch/Before.png)
![After](Assets/Glitch/After.png)

## Shaders

1. `Glitch.shader`
2. `Animated Glitch.shader`

The only difference between these two is that `Animated Glitch.shader` can be adjusted for different levels of glitching. I use it to 'animate' the glitching in the `Glitch.unity` scene.

## Info

This was an experiment in displacing the vertices of a mesh based on texture samples. The texture `Glitch.png` is sampled in the shaders, and the whiter the sample the greater the distortion.
