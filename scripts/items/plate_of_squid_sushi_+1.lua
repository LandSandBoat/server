-----------------------------------
-- ID: 5162
-- Item: plate_of_squid_sushi_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- Health 30
-- Dexterity 6
-- Agility 5
-- Accuracy % 16
-- Ranged ACC % 16
-- Sleep Resist 2
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 5162)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 30)
    target:addMod(xi.mod.DEX, 6)
    target:addMod(xi.mod.AGI, 5)
    target:addMod(xi.mod.FOOD_ACCP, 16)
    target:addMod(xi.mod.FOOD_ACC_CAP, 76)
    target:addMod(xi.mod.FOOD_RACCP, 16)
    target:addMod(xi.mod.FOOD_RACC_CAP, 76)
    target:addMod(xi.mod.SLEEPRES, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 30)
    target:delMod(xi.mod.DEX, 6)
    target:delMod(xi.mod.AGI, 5)
    target:delMod(xi.mod.FOOD_ACCP, 16)
    target:delMod(xi.mod.FOOD_ACC_CAP, 76)
    target:delMod(xi.mod.FOOD_RACCP, 16)
    target:delMod(xi.mod.FOOD_RACC_CAP, 76)
    target:delMod(xi.mod.SLEEPRES, 2)
end

return itemObject
