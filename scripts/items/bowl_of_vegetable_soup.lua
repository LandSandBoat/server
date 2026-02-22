-----------------------------------
-- ID: 4560
-- Item: bowl_of_vegetable_soup
-- Food Effect: 3Hrs, All Races
-----------------------------------
-- Vitality -1
-- Agility 4
-- Ranged Accuracy 5
-- HP Recovered While Healing 3
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, { duration = 10800, origin = user, sourceType = xi.effectSourceType.FOOD, sourceTypeParam = item:getID() })
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.VIT, -1)
    effect:addMod(xi.mod.AGI, 4)
    effect:addMod(xi.mod.RACC, 5)
    effect:addMod(xi.mod.HPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
