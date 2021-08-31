-----------------------------------
-- ID: 4433
-- Item: Bowl of Dhalmel Stew
-- Food Effect: 180Min, All Races
-----------------------------------
-- Strength 4
-- Agility 1
-- Vitality 2
-- Intelligence -2
-- Attack % 25
-- Attack Cap 45
-- Ranged ATT % 25
-- Ranged ATT Cap 45
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4433)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, 4)
    target:addMod(xi.mod.AGI, 1)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.INT, -2)
    target:addMod(xi.mod.FOOD_ATTP, 25)
    target:addMod(xi.mod.FOOD_ATT_CAP, 45)
    target:addMod(xi.mod.FOOD_RATTP, 25)
    target:addMod(xi.mod.FOOD_RATT_CAP, 45)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, 4)
    target:delMod(xi.mod.AGI, 1)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.INT, -2)
    target:delMod(xi.mod.FOOD_ATTP, 25)
    target:delMod(xi.mod.FOOD_ATT_CAP, 45)
    target:delMod(xi.mod.FOOD_RATTP, 25)
    target:delMod(xi.mod.FOOD_RATT_CAP, 45)
end

return item_object
