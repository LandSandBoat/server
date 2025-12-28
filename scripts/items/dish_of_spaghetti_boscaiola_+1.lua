-----------------------------------
-- ID: 5201
-- Item: dish_of_spaghetti_boscaiola_+1
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health % 18
-- Health Cap 130
-- Magic 40
-- Strength -5
-- Dexterity -2
-- Vitality 2
-- Mind 4
-- Store TP +6
-- Magic Regen While Healing 1
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HPP, 18)
    effect:addMod(xi.mod.FOOD_HP_CAP, 130)
    effect:addMod(xi.mod.FOOD_MP, 40)
    effect:addMod(xi.mod.STR, -5)
    effect:addMod(xi.mod.DEX, -2)
    effect:addMod(xi.mod.VIT, 2)
    effect:addMod(xi.mod.MND, 4)
    effect:addMod(xi.mod.STORETP, 6)
    effect:addMod(xi.mod.MPHEAL, 1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
