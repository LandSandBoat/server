-----------------------------------
-- ID: 5623
-- Item: Dish of Spaghetti Tonno Rosso
-- Food Effect: 30 Mins, All Races
-----------------------------------
-- Health % 13
-- Health Cap 180
-- Dexterity 1
-- Vitality 2
-- Store TP +6
-- hMP +1
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 5623)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 13)
    target:addMod(xi.mod.FOOD_HP_CAP, 180)
    target:addMod(xi.mod.DEX, 1)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.STORETP, 6)
    target:addMod(xi.mod.HPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 13)
    target:delMod(xi.mod.FOOD_HP_CAP, 180)
    target:delMod(xi.mod.DEX, 1)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.STORETP, 6)
    target:delMod(xi.mod.HPHEAL, 1)
end

return itemObject
