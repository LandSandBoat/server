-----------------------------------
-- ID: 4325
-- Item: hobgoblin_pie
-- Food Effect: 60Min, All Races
-----------------------------------
-- Health 15
-- Magic 15
-- Agility 4
-- Charisma -7
-- Health Regen While Healing 2
-- Defense % 12 (cap 60)
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
    effect:addMod(xi.mod.FOOD_HP, 15)
    effect:addMod(xi.mod.FOOD_MP, 15)
    effect:addMod(xi.mod.AGI, 4)
    effect:addMod(xi.mod.CHR, -7)
    effect:addMod(xi.mod.HPHEAL, 2)
    effect:addMod(xi.mod.FOOD_DEFP, 12)
    effect:addMod(xi.mod.FOOD_DEF_CAP, 60)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
