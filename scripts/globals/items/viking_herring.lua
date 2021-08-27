-----------------------------------
-- ID: 5183
-- Item: viking_herring
-- Food Effect: 60Min, All Races
-----------------------------------
-- Dexterity 4
-- Mind -3
-- Attack % 12 (cap 75)
-- Ranged ATT % 12 (cap 75)
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) or target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD) then
        result = xi.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 5183)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 4)
    target:addMod(xi.mod.MND, -3)
    target:addMod(xi.mod.FOOD_ATTP, 12)
    target:addMod(xi.mod.FOOD_ATT_CAP, 75)
    target:addMod(xi.mod.FOOD_RATTP, 12)
    target:addMod(xi.mod.FOOD_RATT_CAP, 75)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 4)
    target:delMod(xi.mod.MND, -3)
    target:delMod(xi.mod.FOOD_ATTP, 12)
    target:delMod(xi.mod.FOOD_ATT_CAP, 75)
    target:delMod(xi.mod.FOOD_RATTP, 12)
    target:delMod(xi.mod.FOOD_RATT_CAP, 75)
end

return item_object
