-----------------------------------
-- ID: 5148
-- Item: plate_of_squid_sushi
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health 30
-- Dexterity 6
-- Agility 5
-- Mind -1
-- Accuracy % 15
-- Ranged ACC % 15
-- Sleep Resist 1
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HP, 30)
    effect:addMod(xi.mod.DEX, 6)
    effect:addMod(xi.mod.AGI, 5)
    effect:addMod(xi.mod.MND, -1)
    effect:addMod(xi.mod.FOOD_ACCP, 15)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 72)
    effect:addMod(xi.mod.FOOD_RACCP, 15)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 72)
    effect:addMod(xi.mod.SLEEPRES, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
