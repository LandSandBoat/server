-----------------------------------
-- ID: 18613
-- Fourth Staff
-- Enchantment: "Retrace" (Bastok Markets[S])
-----------------------------------
require("scripts/globals/teleports")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.BASTOK_MARKETS_S, 0, 4)
end

return itemObject
