-----------------------------------
-- ID: 5215
-- Item: plate_of_tentacle_sushi
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP 20
-- Dexterity 3
-- Agility 3
-- Mind -1
-- Accuracy % 20 (cap 18)
-- Ranged Accuracy % 20 (cap 18)
-- Double Attack 1
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5215)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 20)
    target:addMod(xi.mod.DEX, 3)
    target:addMod(xi.mod.AGI, 3)
    target:addMod(xi.mod.MND, -1)
    target:addMod(xi.mod.FOOD_ACCP, 20)
    target:addMod(xi.mod.FOOD_ACC_CAP, 18)
    target:addMod(xi.mod.FOOD_RACCP, 20)
    target:addMod(xi.mod.FOOD_RACC_CAP, 18)
    target:addMod(xi.mod.DOUBLE_ATTACK, 1)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 20)
    target:delMod(xi.mod.DEX, 3)
    target:delMod(xi.mod.AGI, 3)
    target:delMod(xi.mod.MND, -1)
    target:delMod(xi.mod.FOOD_ACCP, 20)
    target:delMod(xi.mod.FOOD_ACC_CAP, 18)
    target:delMod(xi.mod.FOOD_RACCP, 20)
    target:delMod(xi.mod.FOOD_RACC_CAP, 18)
    target:delMod(xi.mod.DOUBLE_ATTACK, 1)
end

return itemObject
