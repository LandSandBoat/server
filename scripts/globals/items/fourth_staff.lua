-----------------------------------
-- ID: 18613
-- Fourth Staff
-- Enchantment: "Retrace" (Bastok Markets[S])
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/teleports")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.BASTOK_MARKETS_S, 0, 4)
end

return item_object
