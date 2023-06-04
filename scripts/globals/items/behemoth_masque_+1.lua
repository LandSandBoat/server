-----------------------------------
-- ID: 26799
-- Behemoth Masque +1
-- Enchantment: "Teleport" (Behemoth's Dominion)
-- Requires player to have previously visited Behemoth's Dominion to activate.
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/teleports")
require("scripts/globals/zone")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:hasVisitedZone(xi.zone.BEHEMOTHS_DOMINION) then
        return 0
    end

    return xi.msg.basic.ITEM_UNABLE_TO_USE_2
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.BEHEMOTHS_DOMINION, 0, 1)
end

return itemObject
