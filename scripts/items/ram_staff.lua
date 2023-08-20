-----------------------------------
-- ID: 18612
-- Ram Staff
-- Enchantment: "Retrace" (Southern San d'Oria[S])
-----------------------------------
require("scripts/globals/teleports")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.SOUTHERN_SAN_DORIA_S, 0, 4)
end

return itemObject
