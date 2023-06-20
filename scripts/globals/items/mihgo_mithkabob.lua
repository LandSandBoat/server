-----------------------------------
-- ID: 5708
-- Item: Mihgo Mithkabob
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- Dexterity 5
-- Vitality 2
-- Mind -2
-- Accuracy +50
-- Ranged Accuracy +50
-- Evasion +5
-- Defense % 25 (cap 95)
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5708)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 5)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.MND, -2)
    target:addMod(xi.mod.ACC, 50)
    target:addMod(xi.mod.RACC, 50)
    target:addMod(xi.mod.EVA, 5)
    target:addMod(xi.mod.FOOD_DEFP, 25)
    target:addMod(xi.mod.FOOD_DEF_CAP, 95)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 5)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.MND, -2)
    target:delMod(xi.mod.ACC, 50)
    target:delMod(xi.mod.RACC, 50)
    target:delMod(xi.mod.EVA, 5)
    target:delMod(xi.mod.FOOD_DEFP, 25)
    target:delMod(xi.mod.FOOD_DEF_CAP, 95)
end

return itemObject
