-----------------------------------
-- ID: 4554
-- Item: serving_of_shallops_tropicale
-- Food Effect: 180Min, All Races
-----------------------------------
-- Magic 20
-- Dexterity 1
-- Vitality 4
-- Intelligence 1
-- Defense % 25
-- Defense Cap 100
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
    effect:addMod(xi.mod.FOOD_MP, 20)
    effect:addMod(xi.mod.DEX, 1)
    effect:addMod(xi.mod.VIT, 4)
    effect:addMod(xi.mod.INT, 1)
    effect:addMod(xi.mod.FOOD_DEFP, 25)
    effect:addMod(xi.mod.FOOD_DEF_CAP, 100)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
