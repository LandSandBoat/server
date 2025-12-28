-----------------------------------
-- ID: 4534
-- Item: bowl_of_medicinal_gruel
-- Food Effect: 4Hrs, All Races
-----------------------------------
-- Vitality -1
-- Agility 2
-- Ranged Accuracy % 15 (cap 15)
-- HP Recovered While Healing 4
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
    effect:addMod(xi.mod.AGI, 2)
    effect:addMod(xi.mod.FOOD_RACCP, 15)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 15)
    effect:addMod(xi.mod.HPHEAL, 4)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
