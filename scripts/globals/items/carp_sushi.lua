-----------------------------------
-- ID: 4407
-- Item: carp_sushi
-- Food Effect: 30Min, All Races
-----------------------------------
-- Dexterity 1
-- Accuracy % 10 (cap 52)
-- HP Recovered While Healing 2
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4407)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.DEX, 1)
    target:addMod(tpz.mod.FOOD_ACCP, 10)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 52)
    target:addMod(tpz.mod.HPHEAL, 2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.DEX, 1)
    target:delMod(tpz.mod.FOOD_ACCP, 10)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 52)
    target:delMod(tpz.mod.HPHEAL, 2)
end

return item_object
