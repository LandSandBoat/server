-----------------------------------
-- ID: 5752
-- Item: Pot-au-feu
-- Food Effect: 30Min, All Races
-----------------------------------
-- Strength 3
-- Agility 3
-- Intelligence -3
-- Ranged Attk % 15 Cap 60
-- Ranged ACC % 10 Cap 50
-- Enmity -3
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
    effect:addMod(xi.mod.STR, 3)
    effect:addMod(xi.mod.AGI, 3)
    effect:addMod(xi.mod.INT, -3)
    effect:addMod(xi.mod.FOOD_RATTP, 15)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 60)
    effect:addMod(xi.mod.FOOD_RACCP, 10)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 50)
    effect:addMod(xi.mod.ENMITY, -3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
