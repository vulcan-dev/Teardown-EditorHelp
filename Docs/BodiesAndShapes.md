### [Back](../README.md)
# Bodies and shapes
The world is made up of shapes connected to bodies. There is an implicit, static body created for each scene. Shapes that do not belong to any body will end up in that implicit, static body.  

The most common use case for bodies is to create dynamic objects. For a body to be meaningful it need one or more shapes as child nodes. All shape child nodes under the same body will move together as one object.  

Advanced: Shapes that are part of a rigid body can be children of other shapes in order to simplify the logical structure in the editor, but at run-time all shapes for a body will just be a flat list of shapes. Therefore, the position and rotation of a shape in the editor may not correspond to the transform you're getting when using GetShapeLocalTransform from a script, since it will always be relative the body, not necessarily the parent node in the editor.