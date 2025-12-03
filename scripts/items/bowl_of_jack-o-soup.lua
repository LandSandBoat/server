-----------------------------------
-- ID: 4522
-- Item: Bowl of Jack-o'-Soup
-- Food Effect: 240Min, All Races
-----------------------------------
-- Health % 2 (cap 120)
-- Agility 3
-- Vitality -1
-- Health Regen While Healing 5
-- Ranged ACC % 8
-- Ranged ACC Cap 25
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
    effect:addMod(xi.mod.FOOD_HPP, 2)
    effect:addMod(xi.mod.FOOD_HP_CAP, 120)
    effect:addMod(xi.mod.AGI, 3)
    effect:addMod(xi.mod.VIT, -1)
    effect:addMod(xi.mod.HPHEAL, 5)
    effect:addMod(xi.mod.FOOD_RACCP, 8)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 25)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
