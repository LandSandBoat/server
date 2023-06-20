-----------------------------------
-- ID: 5555
-- Item: serving_of_flurry_courante
-- Food Effect: 240Min, All Races
-----------------------------------
-- Magic % 19
-- Magic Cap 65
-- Intelligence 2
-- Magic Regen While Healing 1
-- Wind Resist 5
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5555)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_MPP, 19)
    target:addMod(xi.mod.FOOD_MP_CAP, 65)
    target:addMod(xi.mod.INT, 2)
    target:addMod(xi.mod.MPHEAL, 1)
    target:addMod(xi.mod.WIND_MEVA, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_MPP, 19)
    target:delMod(xi.mod.FOOD_MP_CAP, 65)
    target:delMod(xi.mod.INT, 2)
    target:delMod(xi.mod.MPHEAL, 1)
    target:delMod(xi.mod.WIND_MEVA, 5)
end

return itemObject
