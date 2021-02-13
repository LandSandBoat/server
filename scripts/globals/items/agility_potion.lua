-----------------------------------
--  ID: 4205
--  Item: Agility Potion
--  Agility 7
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if (target:hasStatusEffect(tpz.effect.MEDICINE)) then
        return tpz.msg.basic.ITEM_NO_USE_MEDICATED
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.AGI_BOOST, 7, 0, 180)
    target:addStatusEffect(tpz.effect.MEDICINE, 0, 0, 900)
end

return item_object
