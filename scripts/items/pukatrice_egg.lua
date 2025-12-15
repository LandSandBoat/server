-----------------------------------
-- ID: 6274
-- Item: pukatrice_egg
-- Food Effect: 30Min, All Races
-----------------------------------
-- HP +15
-- MP +15
-- STR +2
-- Fire resistance +20
-- Attack +20% (cap 85)
-- Ranged Attack +20% (cap 85)
-- Subtle Blow +8
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
    effect:addMod(xi.mod.FOOD_HP, 15)
    effect:addMod(xi.mod.FOOD_MP, 15)
    effect:addMod(xi.mod.STR, 2)
    effect:addMod(xi.mod.FIRE_MEVA, 20)
    effect:addMod(xi.mod.FOOD_ATTP, 20)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 85)
    effect:addMod(xi.mod.FOOD_RATTP, 20)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 85)
    effect:addMod(xi.mod.SUBTLE_BLOW, 8)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
