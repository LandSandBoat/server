-----------------------------------
-- ID: 5753
-- Item: Pot-au-feu
-- Food Effect: 30Min, All Races
-----------------------------------
-- Strength 4
-- Agility 4
-- Intelligence -3
-- Ranged Attk % 16 Cap 65
-- Ranged ACC % 11 Cap 55
-- Enmity -3
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
    effect:addMod(xi.mod.STR, 4)
    effect:addMod(xi.mod.AGI, 4)
    effect:addMod(xi.mod.INT, -3)
    effect:addMod(xi.mod.FOOD_RATTP, 16)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 65)
    effect:addMod(xi.mod.FOOD_RACCP, 11)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 55)
    effect:addMod(xi.mod.ENMITY, -3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
