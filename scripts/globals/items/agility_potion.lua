-----------------------------------
--  ID: 4205
--  Item: Agility Potion
--  Agility 7
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:hasStatusEffect(xi.effect.MEDICINE) then
        return xi.msg.basic.ITEM_NO_USE_MEDICATED
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.AGI_BOOST, 7, 0, 180)
    target:addStatusEffect(xi.effect.MEDICINE, 0, 0, 900)
end

return itemObject
