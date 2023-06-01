-----------------------------------
-- ID: 5642
-- Item: serving_of_cilbir
-- Food Effect: 3Hrs, All Races
-----------------------------------
-- HP % 5 (cap 150)
-- MP % 5 (cap 100)
-- HP recovered while healing 3
-- MP recovered while healing 3
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5642)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 5)
    target:addMod(xi.mod.FOOD_HP_CAP, 150)
    target:addMod(xi.mod.FOOD_MPP, 5)
    target:addMod(xi.mod.FOOD_MP_CAP, 100)
    target:addMod(xi.mod.MPHEAL, 3)
    target:addMod(xi.mod.HPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 5)
    target:delMod(xi.mod.FOOD_HP_CAP, 150)
    target:delMod(xi.mod.FOOD_MPP, 5)
    target:delMod(xi.mod.FOOD_MP_CAP, 100)
    target:delMod(xi.mod.MPHEAL, 3)
    target:delMod(xi.mod.HPHEAL, 3)
end

return itemObject
