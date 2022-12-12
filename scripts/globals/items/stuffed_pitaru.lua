-----------------------------------
-- ID: 5889
-- Item: stuffed_pitaru
-- Food Effect: 30Min, All Races
-----------------------------------
-- MP +6% (cap 100)
-- Increases rate of magic skill gains by 20%
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if
        target:hasStatusEffect(xi.effect.FOOD) or
        target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
    then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5889)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_MPP, 6)
    target:addMod(xi.mod.FOOD_MP_CAP, 100)
    target:addMod(xi.mod.MAGIC_SKILLUP_RATE, 20)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_MPP, 6)
    target:delMod(xi.mod.FOOD_MP_CAP, 100)
    target:delMod(xi.mod.MAGIC_SKILLUP_RATE, 20)
end

return itemObject
