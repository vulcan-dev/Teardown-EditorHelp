### [Back](README.md)
# Compound
Compounds are used to merge multiple shapes into a single voxel object for performance reasons. All child shapes of a compound will be merged into the compound when loading the level and thereafter removed. Only the tags, texture and other properties of the compound itself will be used at run-time.  

Make sure compounds are rather tight-fitting. A lot of empty space within a compound (or any other shape) will degrade performance. A lot of shapes will also degrade performance, so it's a balance that requires experimentation. A good rule of thumb is that small shapes that can be merged into a compound without making the compound more than half empty is usually a good thing.  

Also note that when shapes are merged into a compound they will all be aligned the same way. You can still merge shapes with different rotation into a compound, but it usually works best if they are at 90 degree angles.  

Built-in tags:  
> **unbreakable**: All shapes in body indestructible  
> **interact=message**: Make shape interactable  
> **explosive=size**: Explode when broken  
> **nocull**: Disable distance culling