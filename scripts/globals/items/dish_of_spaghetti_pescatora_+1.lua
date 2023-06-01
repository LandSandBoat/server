-----------------------------------
-- ID: 5200
-- Item: dish_of_spaghetti_pescatora_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- Health % 15
-- Health Cap 160
-- Vitality 3
-- Mind -1
-- Defense % 22
-- Defense Cap 70
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 5200)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 15)
    target:addMod(xi.mod.FOOD_HP_CAP, 160)
    target:addMod(xi.mod.VIT, 3)
    target:addMod(xi.mod.MND, -1)
    target:addMod(xi.mod.FOOD_DEFP, 22)
    target:addMod(xi.mod.FOOD_DEF_CAP, 70)
    target:addMod(xi.mod.STORETP, 6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 15)
    target:delMod(xi.mod.FOOD_HP_CAP, 160)
    target:delMod(xi.mod.VIT, 3)
    target:delMod(xi.mod.MND, -1)
    target:delMod(xi.mod.FOOD_DEFP, 22)
    target:delMod(xi.mod.FOOD_DEF_CAP, 70)
    target:delMod(xi.mod.STORETP, 6)
end

return itemObject
