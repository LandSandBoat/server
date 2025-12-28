-----------------------------------
-- ID: 6467
-- Item: bowl_of_miso_soup_+1
-- Food Effect: 60Min, All Races
-----------------------------------
-- HP +8% (cap 55)
-- DEX +5
-- AGI +5
-- Accuracy +11% (cap 45)
-- Attack +11% (cap 45)
-- Ranged Accuracy +11% (cap 45)
-- Ranged Attack +11% (cap 45)
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
    effect:addMod(xi.mod.FOOD_HPP, 8)
    effect:addMod(xi.mod.FOOD_HP_CAP, 55)
    effect:addMod(xi.mod.DEX, 5)
    effect:addMod(xi.mod.AGI, 5)
    effect:addMod(xi.mod.FOOD_ACCP, 11)
    effect:addMod(xi.mod.FOOD_ACC_CAP, 45)
    effect:addMod(xi.mod.FOOD_RACCP, 11)
    effect:addMod(xi.mod.FOOD_RACC_CAP, 45)
    effect:addMod(xi.mod.FOOD_ATTP, 11)
    effect:addMod(xi.mod.FOOD_ATT_CAP, 45)
    effect:addMod(xi.mod.FOOD_RATTP, 11)
    effect:addMod(xi.mod.FOOD_RATT_CAP, 45)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
