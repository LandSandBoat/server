-----------------------------------
-- ID: 4323
-- Item: bowl_of_vegetable_broth
-- Food Effect: 4Hrs, All Races
-----------------------------------
-- Vitality -1
-- Agility 5
-- Ranged Accuracy 6
-- HP Recovered While Healing 3
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
    effect:addMod(xi.mod.VIT, -1)
    effect:addMod(xi.mod.AGI, 5)
    effect:addMod(xi.mod.RACC, 6)
    effect:addMod(xi.mod.HPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
