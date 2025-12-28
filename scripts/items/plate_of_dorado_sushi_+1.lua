-----------------------------------
-- ID: 5179
-- Item: plate_of_dorado_sushi_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- Dexterity 5
-- Accuracy % 16
-- Accuracy Cap 76
-- Ranged ACC % 16
-- Ranged ACC Cap 76
-- Sleep Resist 2
-- Enmity 5
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.ENMITY, 5)
    effect:addMod(xi.mod.DEX, 5)
    effect:addMod(xi.mod.FOOD_ACCP, 16)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 76)
    effect:addMod(xi.mod.FOOD_RACCP, 16)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 76)
    effect:addMod(xi.mod.SLEEPRES, 2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
