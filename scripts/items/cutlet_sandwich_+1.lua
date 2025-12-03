-----------------------------------
-- ID: 6397
-- Item: cutlet_sandwich_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- HP +45
-- STR +8
-- INT -8
-- Fire resistance +21
-- Attack +21% (cap 125)
-- Ranged Attack +21% (cap 125)
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
    effect:addMod(xi.mod.FOOD_HP, 45)
    effect:addMod(xi.mod.STR, 8)
    effect:addMod(xi.mod.INT, -8)
    effect:addMod(xi.mod.FIRE_MEVA, 21)
    effect:addMod(xi.mod.FOOD_ATTP, 21)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 125)
    effect:addMod(xi.mod.FOOD_RATTP, 21)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 125)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
