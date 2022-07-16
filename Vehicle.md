### [Back](README.md)
# Vehicle
The vehicle defines a vehicle that can be driven in the game (also boats). It requires at least one body as child node. The body should have at least one shape and wheels. I no wheel are attached, the vehicle will be considered a boat.

Built-in tags:  
boat: Mark vehicle as boat (affects hud)  
nodrive: Vehicle cannot be driven by player  
brokenthreshold: Fraction of original voxel count vehicle is no longer drivable. Default is 0.7 for boats and 0.5 for wheeled vehicles.  
sinkthreshold: For boats only. Fraction of original voxel count where no extra floatation. Default is 90% of brokenthreshold.  

A vehicle may include a number of special locations with the following tags:  
exhaust: exhaust pipe, can be multiple
player: driver seat location  
propeller: engine location for boats  
exit: player location when exiting vehicle