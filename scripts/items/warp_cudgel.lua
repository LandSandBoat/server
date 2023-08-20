-----------------------------------
-- ID: 17040
-- Warp Cudgel
-- Transports the user to their Home Point
-----------------------------------
require("scripts/globals/teleports")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.WARP, 0, 2)
end

return itemObject
