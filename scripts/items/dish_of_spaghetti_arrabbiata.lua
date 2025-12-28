-----------------------------------
-- ID: 5211
-- Item: dish_of_spaghetti_arrabbiata
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP +17% (cap 140)
-- Strength +5
-- Vitality +2
-- Intelligence -7
-- Attack +22% (cap 90)
-- Ranged Attack +22% (cap 90)
-- Store TP +6
-- Sleep resistance +8
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
    effect:addMod(xi.mod.FOOD_HPP, 17)
    effect:addMod(xi.mod.FOOD_HP_CAP, 140)
    effect:addMod(xi.mod.STR, 5)
    effect:addMod(xi.mod.VIT, 2)
    effect:addMod(xi.mod.INT, -7)
    effect:addMod(xi.mod.FOOD_ATTP, 22)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 90)
    effect:addMod(xi.mod.FOOD_RATTP, 22)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 90)
    effect:addMod(xi.mod.STORETP, 6)
    effect:addMod(xi.mod.SLEEPRES, 8)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
