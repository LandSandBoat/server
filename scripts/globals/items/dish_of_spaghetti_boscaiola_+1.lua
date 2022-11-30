-----------------------------------
-- ID: 5201
-- Item: dish_of_spaghetti_boscaiola_+1
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health % 18
-- Health Cap 130
-- Magic 40
-- Strength -5
-- Dexterity -2
-- Vitality 2
-- Mind 4
-- Store TP +6
-- Magic Regen While Healing 1
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5201)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 18)
    target:addMod(xi.mod.FOOD_HP_CAP, 130)
    target:addMod(xi.mod.MP, 40)
    target:addMod(xi.mod.STR, -5)
    target:addMod(xi.mod.DEX, -2)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.MND, 4)
    target:addMod(xi.mod.STORETP, 6)
    target:addMod(xi.mod.MPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 18)
    target:delMod(xi.mod.FOOD_HP_CAP, 130)
    target:delMod(xi.mod.MP, 40)
    target:delMod(xi.mod.STR, -5)
    target:delMod(xi.mod.DEX, -2)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.MND, 4)
    target:delMod(xi.mod.STORETP, 6)
    target:delMod(xi.mod.MPHEAL, 1)
end

return itemObject
