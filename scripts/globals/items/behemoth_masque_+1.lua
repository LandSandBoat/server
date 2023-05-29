-----------------------------------
-- ID: 26799
-- Behemoth Masque +1
-- Enchantment: "Teleport" (Behemoth's Dominion)
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/teleports")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.BEHEMOTHS_DOMINION, 0, 1)
end

return itemObject
