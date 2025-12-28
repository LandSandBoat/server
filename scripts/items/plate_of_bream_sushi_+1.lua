-----------------------------------
-- ID: 5177
-- Item: plate_of_bream_sushi_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- Dexterity 6
-- Vitality 5
-- Accuracy % 17 (cap 80)
-- Ranged ACC % 17 (cap 80)
-- Sleep Resist 2
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
    effect:addMod(xi.mod.DEX, 6)
    effect:addMod(xi.mod.VIT, 5)
    effect:addMod(xi.mod.FOOD_ACCP, 17)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 80)
    effect:addMod(xi.mod.FOOD_RACCP, 17)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 80)
    effect:addMod(xi.mod.SLEEPRES, 2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
