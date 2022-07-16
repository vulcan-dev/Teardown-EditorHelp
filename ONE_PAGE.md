### [Back](README.md)
# General
The teardown editor is used in combination with MagicaVoxel to create content for Teardown.

The scene explorer on the left shows the scene structure, while the graphical 3D view gives a visual representation. When selecting an object in the scene explorer, the corresponding object will be highlighted in the 3D view and vice versa.

# Controls
> F5 - Play level in preview mode. Level is not saved  
> F4 - Return to editor from preview mode  
Hold right mouse button + F5 - Play level with spawn point at mouse pointer  


### Scene view
> Left mouse button - select  
> Right mouse button - rotate camera  
> Middle mouse button - move camera  
> Mouse wheel - zoom camera  
> Hold Middle mouse button and click mouse - Center camera

> P + left mouse button: Place object at location  
> M + drag: Move object in XZ plane  
> R + drag: Rotate object around Y axis  
> S + drag qizmo: Resize voxbox or script object  
> Shift + drag gizmo: Rotate in parent space  
> Shift + ctrl + drag gizmo: Rotate in local space  
> Ctrl + drag gizmo: Move object without > moving children

### Scene Explorer
> Ctrl + up/down arrow: Move node upwards/downwards  
> Shift + left mouse button: Select range  
> Ctrl + left mouse button: Mutiple select  

# Nodes and properties
The scene explorer contains a hierarchy of nodes. When selecting a node the node properties will show up in the properties window. Hover over a property field to see description.  

To add a node, right - click the desired parent node in the scene explorer and choose a type under "New"  

If a property is not explicitly given, the inherited value will be used (purple). If there is no inherited value, the default value will be used (gray).  

For inherited property values, see group node

# Paths
All paths in the teardown editor uses the following convention:  

MOD - refers to the current mod folder  
LEVEL - refers to a folder with the same name as the level XML (without .xml)

# Bodies and shapes
The world is made up of shapes connected to bodies. There is an implicit, static body created for each scene. Shapes that do not belong to any body will end up in that implicit, static body.  

The most common use case for bodies is to create dynamic objects. For a body to be meaningful it need one or more shapes as child nodes. All shape child nodes under the same body will move together as one object.  

Advanced: Shapes that are part of a rigid body can be children of other shapes in order to simplify the logical structure in the editor, but at run-time all shapes for a body will just be a flat list of shapes. Therefore, the position and rotation of a shape in the editor may not correspond to the transform you're getting when using GetShapeLocalTransform from a script, since it will always be relative the body, not necessarily the parent node in the editor.

# Layers
Layers is an advanced feature that can be used to create multiple variants of the same level. A group can be configured to only show up on a particular layer, or be excluded from a layer.  

When starting a level, a combination of layers is given to identify which version of the level to run. If unsure, do not use layers.

# Scene
This is the root node for each level. It is mostly used to configure the shadow volume size. A level can only have one scene node.  

Keep the shadow volume as small as possible since it consumes a lot of video RAM. In order to work on AMD graphics cards, the shadow volume has to be kept below 400 meters in any direction.

# Body
The body node will create a rigid body and may consist of multiple connected shapes. In most cases you want to set the dynamic property to true.  

### **Built-in tags**:  
> **unbreakable**: All shapes in body indestructible  
> **awake**: Start dynamic body in a simulated state  
> **interact=message**: Make shape interactable  
> **explosive=size**: Explode when broken  
> **nocull**: Disable distance culling

# Boundary
The orange grid enclosing the play area. Only one boundary per level should be used. If multiple are defined, the last one will be used.

# Environment
The environment node controls the ambient lighting, time of day, skybox etc. Only one environment per level should be used.

# Group
The group node is just a way to organize nodes in the editor and has no effect at run-time. Group nodes are also used to specify layer and inherited properties.

Inherited properties: The prop0, prop1... properties of a group can be used to set default values on child nodes. This is often useful to set multiple parameters without having to do it on every node. Example: set prop0 to "color=1 0 0". All child nodes that has the "color" property will now have default value "1 0 0"

Advanced: To make a group only available on a specific layer, specify one or more (space separated) layers in the layers property. A minus sign prefix to the layer name will make the group diappear for a specific layer.

# Instance
Instances are used to place predefined groups of content (prefabs) into the scene. This is useful to place multiple instances of complex objects into the scene. Changing the prefab will affect all instances.

Prefabs are created from groups. To create a prefab, right click a group in scene explorer and select "Create new prefab...".

If you want to make modifications to a prefab, right-click an instance in scene explorer and select "Convert to group". This will make a local, editable copy of the instance. When you are done editing you right click the group and select "Commit to prefab". This action saves the prefab and updates all instances.

# Joint
Joints connect shapes to restrict their motion. Joints are automatically attached to the two closest shapes within the search radius (size).

# Light
A light node will create a light source in the world. If the light has a parent shape, the light will be automatically turned off when the shape breaks, and the intensity will be scaled by the emissive scale of that shape.

Built-in tags:  
> **night**: Only enabled is environment has nightlight property

# Location
Locations are used to mark a location in the world, which can then be retrieved from script. In some special cases, for instance vehicles and ropes, the locations have specific purposes in the game engine.

# Rope
Rope is a special joint type that connect to bodies with a visible wire. Use the two locations to specify rope attachment points.

# Screen
A screen will display the output of a script in the world. If the screen has a parent shape, the screen will turn off when the shape is broken. If the screen has an area light source as child, that light source will emit light based on the screen content.

Built-in tags:  
> **interactive**: Use cursor and allow player interaction (needs scripting)

# Script
A script node is used to add game logic through a Lua script. If the script has child nodes, those child nodes can be retrieved using the find functions in the Lua API. This is useful to create multiple instances of a script that each control their own part of the scene.

# Spawnpoint
The spawnpoint node determines the player initial position and orientation when starting the level. There should be only a single spawn point per level.

# Trigger
A trigger is a volume that can be used in scripting for game logic. A trigger can also be used for environmental background sounds.

# Vehicle
The vehicle defines a vehicle that can be driven in the game (also boats). It requires at least one body as child node. The body should have at least one shape and wheels. I no wheel are attached, the vehicle will be considered a boat.

Built-in tags:  
> **boat**: Mark vehicle as boat (affects hud)  
> **nodrive**: Vehicle cannot be driven by player  
> 
> **brokenthreshold**: Fraction of original voxel count vehicle is no longer drivable. > Default is 0.7 for boats and 0.5 for wheeled vehicles.  
> 
> **sinkthreshold**: For boats only. Fraction of original voxel count where no extra > floatation. Default is 90% of brokenthreshold.  

A vehicle may include a number of special locations with the following tags:  
exhaust: exhaust pipe, can be multiple
player: driver seat location  
propeller: engine location for boats  
exit: player location when exiting vehicle

# Vox
The vox node is a shape that imports a .vox object modeled in MagicaVoxel. If the file includes named objects, you can specify the object name to import only a specific object from the file.

Built-in tags:  
> **unbreakable**: All shapes in body indestructible  
> **interact=message**: Make shape interactable  
> **explosive=size**: Explode when broken  
> **nocull**: Disable distance culling

# Voxbox
A voxbox is a single, solid box filled with voxels. If a brush is specified, the contents of a single-shape .vox file is used to fill the box in a repeating manner. This is very useful to create everything from walls, floors and fences, to more exotic things like staircases.

Built-in tags:  
> **unbreakable**: All shapes in body indestructible  
> **interact=message**: Make shape interactable  
> **explosive=size**: Explode when broken  
> **nocull**: Disable distance culling

# Voxagon
A voxagon is similar to a voxbox, but the geometry is an extruded 2D polygon. This is useful to create more irregular shapes.

Built-in tags:  
> **unbreakable**: All shapes in body indestructible  
> **interact=message**: Make shape interactable  
> **explosive=size**: Explode when broken  
> **nocull**: Disable distance culling

# Voxscript
This is an advanced feature that is used for procedurally generating voxel objects with a Lua script.

Built-in tags:  
> **unbreakable**: All shapes in body indestructible  
> **interact=message**: Make shape interactable  
> **explosive=size**: Explode when broken  
> **nocull**: Disable distance culling

# Water
Used to create water in the game. Water can be defined using either a box or a polygon.

# Wheel
Used for wheels in vehicles. Wheel nodes should have a vehicle body parent node. Each wheel should also have a child shape that defines the appearance and size of the wheel.