-----------------------------------
-- ID: 4369
-- Item: four-leaf_mandragora_bud
-- Food Effect: 60Min, All Races
-----------------------------------
-- Agility 3
-- Vitality -5
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
    effect:addMod(xi.mod.AGI, 3)
    effect:addMod(xi.mod.VIT, -5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
