-----------------------------------
-- ID: 4603
-- Item: cup_of_chamomile_tea
-- Food Effect: 180Min, All Races
-----------------------------------
-- Magic 8
-- Vitality -2
-- Charisma 2
-- Magic Regen While Healing 1
-- Sleep resistance -30
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
    effect:addMod(xi.mod.FOOD_MP, 8)
    effect:addMod(xi.mod.VIT, -2)
    effect:addMod(xi.mod.CHR, 2)
    effect:addMod(xi.mod.MPHEAL, 1)
    effect:addMod(xi.mod.SLEEPRES, -30)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
