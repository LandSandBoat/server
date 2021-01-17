-----------------------------------------
-- ID: 18614
-- Cobra Staff
-- Enchantment: "Retrace" (Windurst Waters[S])
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/teleports")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.WINDURST_WATERS_S, 0, 4)
end

return item_object
