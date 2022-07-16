local order = {
    "General",
    "Controls",
    "NodesAndProperties",
    "Paths",
    "BodiesAndShapes",
    "Layers",
    "Scene",
    "Body",
    "Boundary",
    "Compound",
    "Environment",
    "Group",
    "Instance",
    "Joint",
    "Light",
    "Location",
    "Rope",
    "Screen",
    "Script",
    "Spawnpoint",
    "Trigger",
    "Vehicle",
    "Vox",
    "Voxbox",
    "Voxagon",
    "Voxscript",
    "Water",
    "Wheel"
}

local lines = {}
for i, v in ipairs(order) do
    local file = io.open("./Docs/" .. v .. ".md", "r")
    if not file then
        print("Could not find " .. v .. ".md")
        return
    end

    local ln = 0

    for line in file:lines() do
        if ln > 0 then
            table.insert(lines, line)
        end

        ln = ln + 1
    end

    file:close()
end

local outFile = io.open("ONE_PAGE.md", "w")
outFile:write("### [Back](README.md)\n")
for i, v in ipairs(lines) do
    outFile:write(v .. "\n")
end
outFile:close()