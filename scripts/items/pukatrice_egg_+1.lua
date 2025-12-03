-----------------------------------
-- ID: 6275
-- Item: pukatrice_egg_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- HP +20
-- MP +20
-- STR +3
-- Fire resistance +21
-- Attack +21% (cap 90)
-- Ranged Attack +21% (cap 90)
-- Subtle Blow +9
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
    effect:addMod(xi.mod.FOOD_HP, 20)
    effect:addMod(xi.mod.FOOD_MP, 20)
    effect:addMod(xi.mod.STR, 3)
    effect:addMod(xi.mod.FIRE_MEVA, 21)
    effect:addMod(xi.mod.FOOD_ATTP, 21)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 90)
    effect:addMod(xi.mod.FOOD_RATTP, 21)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 90)
    effect:addMod(xi.mod.SUBTLE_BLOW, 9)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
