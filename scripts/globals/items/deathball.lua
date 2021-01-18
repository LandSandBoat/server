-----------------------------------
-- ID: 4566
-- Item: Deathball
-- Food Effect: 3 Mins, All Races
-- Poison 2HP / 3Tic
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if (target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD)) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 180, 4566)
    if (not target:hasStatusEffect(tpz.effect.POISON)) then
        target:addStatusEffect(tpz.effect.POISON, 2, 3, 180)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end

return item_object
