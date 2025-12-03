-----------------------------------
-- ID: 6396
-- Item: cutlet_sandwich
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP +40
-- STR +7
-- INT -7
-- Fire resistance +20
-- Attack +20% (cap 120)
-- Ranged Attack +20% (cap 120)
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
    effect:addMod(xi.mod.FOOD_HP, 40)
    effect:addMod(xi.mod.STR, 7)
    effect:addMod(xi.mod.INT, -7)
    effect:addMod(xi.mod.FIRE_MEVA, 20)
    effect:addMod(xi.mod.FOOD_ATTP, 20)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 120)
    effect:addMod(xi.mod.FOOD_RATTP, 20)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 120)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
