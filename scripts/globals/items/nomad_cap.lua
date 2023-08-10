-----------------------------------
-- ID: 16119
-- Nomad Cap
-- Transports the user to their Home Nation
-- TODO: Confirm wiki claims of random zone destinations among a same nation.
-----------------------------------
local itemObject = {}

local pos =
{
    -- Content  [Nation] = {   x,   y,  z, rot, zone },
    [xi.nation.SANDORIA] = { 126,   0,  -1, 122, 231 },
    [xi.nation.BASTOK  ] = { 106,   0, -71, 130, 234 },
    [xi.nation.WINDURST] = { 197, -12, 224,  65, 240 },
}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local nation = target:getNation(target)

    target:setPos(unpack(pos[nation]))
end

return itemObject
