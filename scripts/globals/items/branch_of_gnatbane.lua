-----------------------------------
-- ID: 5984
-- Item: Branch of Gnatbane
-- Food Effect: 10 Mins, All Races
-- Poison 10HP / 3Tic
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if (target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD)) then
        return tpz.msg.basic.IS_FULL
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 600, 5984)
    if (not target:hasStatusEffect(tpz.effect.POISON)) then
        target:addStatusEffect(tpz.effect.POISON, 10, 3, 600)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end

return item_object
