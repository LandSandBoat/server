-----------------------------------
-- ID: 4490
-- Item: Pickled Herring
-- Food Effect: 30Min, All Races
-----------------------------------
-- Dexterity 3
-- Mind -3
-- Attack % 12 (cap 70)
-- Ranged ATT % 12 (cap 70)
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 4490)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 3)
    target:addMod(xi.mod.MND, -3)
    target:addMod(xi.mod.FOOD_ATTP, 12)
    target:addMod(xi.mod.FOOD_ATT_CAP, 70)
    target:addMod(xi.mod.FOOD_RATTP, 12)
    target:addMod(xi.mod.FOOD_RATT_CAP, 70)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 3)
    target:delMod(xi.mod.MND, -3)
    target:delMod(xi.mod.FOOD_ATTP, 12)
    target:delMod(xi.mod.FOOD_ATT_CAP, 70)
    target:delMod(xi.mod.FOOD_RATTP, 12)
    target:delMod(xi.mod.FOOD_RATT_CAP, 70)
end

return item_object
