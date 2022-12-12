-----------------------------------
-- ID: 4332
-- Item: orange_kuchen_+1
-- Food Effect: 4Hrs, All Races
-----------------------------------
-- MP % 13 (cap 80)
-- MP Recovered While Healing 1
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 4332)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_MPP, 13)
    target:addMod(xi.mod.FOOD_MP_CAP, 80)
    target:addMod(xi.mod.MPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_MPP, 13)
    target:delMod(xi.mod.FOOD_MP_CAP, 80)
    target:delMod(xi.mod.MPHEAL, 1)
end

return itemObject
