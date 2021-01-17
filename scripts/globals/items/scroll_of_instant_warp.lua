-----------------------------------------
-- ID: 4181
-- Scroll of Instant Warp
-- Transports the user to their Home Point
-----------------------------------------
require("scripts/globals/teleports")
require("scripts/globals/status")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.WARP, 0, 1)
end

return item_object
