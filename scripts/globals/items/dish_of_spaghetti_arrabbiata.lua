-----------------------------------
-- ID: 5211
-- Item: dish_of_spaghetti_arrabbiata
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP +17% (cap 140)
-- Strength +5
-- Vitality +2
-- Intelligence -7
-- Attack +22% (cap 90)
-- Ranged Attack +22% (cap 90)
-- Store TP +6
-- Sleep resistance +8
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5211)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 17)
    target:addMod(xi.mod.FOOD_HP_CAP, 140)
    target:addMod(xi.mod.STR, 5)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.INT, -7)
    target:addMod(xi.mod.FOOD_ATTP, 22)
    target:addMod(xi.mod.FOOD_ATT_CAP, 90)
    target:addMod(xi.mod.FOOD_RATTP, 22)
    target:addMod(xi.mod.FOOD_RATT_CAP, 90)
    target:addMod(xi.mod.STORETP, 6)
    target:addMod(xi.mod.SLEEPRES, 8)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 17)
    target:delMod(xi.mod.FOOD_HP_CAP, 140)
    target:delMod(xi.mod.STR, 5)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.INT, -7)
    target:delMod(xi.mod.FOOD_ATTP, 22)
    target:delMod(xi.mod.FOOD_ATT_CAP, 90)
    target:delMod(xi.mod.FOOD_RATTP, 22)
    target:delMod(xi.mod.FOOD_RATT_CAP, 90)
    target:delMod(xi.mod.STORETP, 6)
    target:delMod(xi.mod.SLEEPRES, 8)
end

return itemObject
