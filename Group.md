# Group
The group node is just a way to organize nodes in the editor and has no effect at run-time. Group nodes are also used to specify layer and inherited properties.

Inherited properties: The prop0, prop1... properties of a group can be used to set default values on child nodes. This is often useful to set multiple parameters without having to do it on every node. Example: set prop0 to "color=1 0 0". All child nodes that has the "color" property will now have default value "1 0 0"

Advanced: To make a group only available on a specific layer, specify one or more (space separated) layers in the layers property. A minus sign prefix to the layer name will make the group diappear for a specific layer.