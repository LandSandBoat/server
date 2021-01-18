-----------------------------------
-- ID: 17040
-- Warp Cudgel
-- Transports the user to their Home Point
-----------------------------------
require("scripts/globals/teleports")
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.WARP, 0, 2)
end

return item_object
