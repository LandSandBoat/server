-----------------------------------
-- ID: 5930
-- Item: Bowl of Sprightly Soup
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- MP 30
-- Mind 4
-- HP Recovered While Healing 4
-- Enmity -4
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
    effect:addMod(xi.mod.FOOD_MP, 30)
    effect:addMod(xi.mod.MND, 4)
    effect:addMod(xi.mod.HPHEAL, 4)
    effect:addMod(xi.mod.ENMITY, -4)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
