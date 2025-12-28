-----------------------------------
-- ID: 5212
-- Item: dish_of_spaghetti_arrabbiata_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- HP +17% (cap 150)
-- Strength 5
-- Vitality 2
-- Intelligence -7
-- Attack +23% (cap 100)
-- Ranged Attack +23% (cap 100)
-- Store TP +6
-- Sleep resistance +8
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
    effect:addMod(xi.mod.FOOD_HPP, 17)
    effect:addMod(xi.mod.FOOD_HP_CAP, 150)
    effect:addMod(xi.mod.STR, 5)
    effect:addMod(xi.mod.VIT, 2)
    effect:addMod(xi.mod.INT, -7)
    effect:addMod(xi.mod.FOOD_ATTP, 23)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 100)
    effect:addMod(xi.mod.FOOD_RATTP, 23)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 100)
    effect:addMod(xi.mod.STORETP, 6)
    effect:addMod(xi.mod.SLEEPRES, 8)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
