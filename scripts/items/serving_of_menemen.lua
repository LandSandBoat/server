-----------------------------------
-- ID: 5586
-- Item: serving_of_menemen
-- Food Effect: 3Hrs, All Races
-----------------------------------
-- HP 30
-- MP 30
-- Agility 1
-- Intelligence -1
-- HP recovered while healing 1
-- MP recovered while healing 1
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HP, 30)
    effect:addMod(xi.mod.FOOD_MP, 30)
    effect:addMod(xi.mod.AGI, 1)
    effect:addMod(xi.mod.INT, -1)
    effect:addMod(xi.mod.HPHEAL, 1)
    effect:addMod(xi.mod.MPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
