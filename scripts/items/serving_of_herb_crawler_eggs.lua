-----------------------------------
-- ID: 4552
-- Item: serving_of_herb_crawler_eggs
-- Food Effect: 180Min, All Races
-----------------------------------
-- Health % 6
-- Health Cap 80
-- Magic 10
-- Agility 3
-- Vitality -1
-- Evasion 8
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
    effect:addMod(xi.mod.FOOD_HPP, 6)
    effect:addMod(xi.mod.FOOD_HP_CAP, 80)
    effect:addMod(xi.mod.FOOD_MP, 10)
    effect:addMod(xi.mod.AGI, 3)
    effect:addMod(xi.mod.VIT, -1)
    effect:addMod(xi.mod.EVA, 8)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
