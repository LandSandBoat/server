-----------------------------------
-- ID: 5587
-- Item: serving_of_menemen_+1
-- Food Effect: 4Hrs, All Races
-----------------------------------
-- HP 35
-- MP 35
-- Agility 2
-- Intelligence -2
-- HP recovered while healing 2
-- MP recovered while healing 2
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
    effect:addMod(xi.mod.FOOD_HP, 35)
    effect:addMod(xi.mod.FOOD_MP, 35)
    effect:addMod(xi.mod.AGI, 2)
    effect:addMod(xi.mod.INT, -2)
    effect:addMod(xi.mod.HPHEAL, 2)
    effect:addMod(xi.mod.MPHEAL, 2)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
