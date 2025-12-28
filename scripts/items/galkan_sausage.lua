-----------------------------------
-- ID: 4395
-- Item: galkan_sausage
-- Food Effect: 30Min, All Races
-----------------------------------
-- Multi-Race Effects
-- Galka
-- Strength 3
-- Intelligence -1
-- Attack % 25
-- Attack Cap 30
-- Ranged ATT % 25
-- Ranged ATT Cap 30
--
-- Other
-- Strength 3
-- Intelligence -4
-- Attack 9
-- Ranged ATT  9
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
    if target:getRace() ~= xi.race.GALKA then
        effect:addMod(xi.mod.STR, 3)
        effect:addMod(xi.mod.INT, -4)
        effect:addMod(xi.mod.ATT, 9)
        effect:addMod(xi.mod.RATT, 9)
    else
        effect:addMod(xi.mod.STR, 3)
        effect:addMod(xi.mod.INT, -1)
        effect:addMod(xi.mod.FOOD_ATTP, 25)
        effect:addMod(xi.mod.FOOD_ATT_CAP, 30)
        effect:addMod(xi.mod.FOOD_RATTP, 25)
        effect:addMod(xi.mod.FOOD_RATT_CAP, 30)
    end
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
