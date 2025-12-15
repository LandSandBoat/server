-----------------------------------
-- ID: 5679
-- Item: cathedral_salad
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- MP 15% Cap 90
-- Agility 7
-- Mind 7
-- Strength -5
-- Vitality -5
-- Ranged Accuracy +17
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_MPP, 15)
    effect:addMod(xi.mod.FOOD_MP_CAP, 90)
    effect:addMod(xi.mod.AGI, 7)
    effect:addMod(xi.mod.MND, 7)
    effect:addMod(xi.mod.STR, -5)
    effect:addMod(xi.mod.VIT, -5)
    effect:addMod(xi.mod.RACC, 17)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
