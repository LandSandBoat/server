-----------------------------------
-- ID: 5614
-- Item: konigskuchen
-- Food Effect: 180Min, All Races
-----------------------------------
-- Health 8
-- Magic % 3
-- Magic Cap 13
-- Intelligence 2
-- hMP +1
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5614)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 8)
    target:addMod(xi.mod.FOOD_MPP, 3)
    target:addMod(xi.mod.FOOD_MP_CAP, 13)
    target:addMod(xi.mod.INT, 2)
    target:addMod(xi.mod.MPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 8)
    target:delMod(xi.mod.FOOD_MPP, 3)
    target:delMod(xi.mod.FOOD_MP_CAP, 13)
    target:delMod(xi.mod.INT, 2)
    target:delMod(xi.mod.MPHEAL, 1)
end

return itemObject
