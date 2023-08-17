-----------------------------------
-- ID: 27623
-- Jody Shield
-- Enchantment: Jody's Meet and Greet
-- Requires player to have previously visited Wajaom Woodlands to activate.
-----------------------------------
require("scripts/globals/msg")
require("scripts/globals/teleports")
require("scripts/globals/zone")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:hasVisitedZone(xi.zone.WAJAOM_WOODLANDS) then
        return 0
    end

    return xi.msg.basic.ITEM_UNABLE_TO_USE_2
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.WAJAOM_JODY, 0, 1)
end

return itemObject
