-----------------------------------
-- ID: 5217
-- Item: serving_of_salmon_eggs
-- Food Effect: 5Min, All Races
-----------------------------------
-- Health 6
-- Magic 6
-- Dexterity 2
-- Mind -3
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 5217)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HP, 6)
    target:addMod(xi.mod.FOOD_MP, 6)
    target:addMod(xi.mod.DEX, 2)
    target:addMod(xi.mod.MND, -3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HP, 6)
    target:delMod(xi.mod.FOOD_MP, 6)
    target:delMod(xi.mod.DEX, 2)
    target:delMod(xi.mod.MND, -3)
end

return itemObject
