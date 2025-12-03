-----------------------------------
-- ID: 6459
-- Item: bowl_of_soy_ramen_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- HP +55
-- STR +6
-- VIT +6
-- AGI +4
-- Attack +11% (cap 175)
-- Ranged Attack +11% (cap 175)
-- Resist Slow +15
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
    effect:addMod(xi.mod.FOOD_HP, 55)
    effect:addMod(xi.mod.STR, 6)
    effect:addMod(xi.mod.VIT, 6)
    effect:addMod(xi.mod.AGI, 4)
    effect:addMod(xi.mod.FOOD_ATTP, 11)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 175)
    effect:addMod(xi.mod.FOOD_RATTP, 11)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 175)
    effect:addMod(xi.mod.SLOWRES, 15)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
