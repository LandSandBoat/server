-----------------------------------
-- ID: 4452
-- Item: bowl_of_shark_fin_soup
-- Food Effect: 3Hrs, All Races
-----------------------------------
-- HP % 5 (cap 150)
-- MP 5
-- Dexterity 4
-- HP Recovered While Healing 9
-- Attack % 14 (cap 85)
-- Ranged Attack % 14 (cap 85)
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
    effect:addMod(xi.mod.FOOD_HPP, 5)
    effect:addMod(xi.mod.FOOD_HP_CAP, 150)
    effect:addMod(xi.mod.DEX, 4)
    effect:addMod(xi.mod.FOOD_MP, 5)
    effect:addMod(xi.mod.HPHEAL, 9)
    effect:addMod(xi.mod.FOOD_ATTP, 14)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 85)
    effect:addMod(xi.mod.FOOD_RATTP, 14)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 85)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
