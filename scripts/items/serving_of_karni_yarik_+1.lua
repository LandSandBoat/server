-----------------------------------
-- ID: 5589
-- Item: serving_of_karni_yarik_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- Agility 4
-- Vitality -2
-- Attack % 22 (cap 70)
-- Ranged Attack % 22 (cap 70)
-- Evasion +7
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
    effect:addMod(xi.mod.AGI, 4)
    effect:addMod(xi.mod.VIT, -2)
    effect:addMod(xi.mod.FOOD_ATTP, 22)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 70)
    effect:addMod(xi.mod.FOOD_RATTP, 22)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 70)
    effect:addMod(xi.mod.EVA, 7)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
