-----------------------------------
-- ID: 5199
-- Item: dish_of_spaghetti_carbonara_+1
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health % 14
-- Health Cap 180
-- Magic 15
-- Strength 4
-- Vitality 2
-- Intelligence -3
-- Attack % 17
-- Attack Cap 70
-- Store TP 6
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 5199)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 14)
    target:addMod(xi.mod.FOOD_HP_CAP, 180)
    target:addMod(xi.mod.MP, 15)
    target:addMod(xi.mod.STR, 4)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.INT, -3)
    target:addMod(xi.mod.FOOD_ATTP, 17)
    target:addMod(xi.mod.FOOD_ATT_CAP, 70)
    target:addMod(xi.mod.STORETP, 6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 14)
    target:delMod(xi.mod.FOOD_HP_CAP, 180)
    target:delMod(xi.mod.MP, 15)
    target:delMod(xi.mod.STR, 4)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.INT, -3)
    target:delMod(xi.mod.FOOD_ATTP, 17)
    target:delMod(xi.mod.FOOD_ATT_CAP, 70)
    target:delMod(xi.mod.STORETP, 6)
end

return itemObject
