-----------------------------------
--  ID: 4201
--  Item: Dexterity Potion
--  Dexterity 7
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if (target:hasStatusEffect(xi.effect.MEDICINE)) then
        return xi.msg.basic.ITEM_NO_USE_MEDICATED
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.DEX_BOOST, 7, 0, 180)
    target:addStatusEffect(xi.effect.MEDICINE, 0, 0, 900)
end

return item_object
