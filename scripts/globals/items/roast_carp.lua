-----------------------------------
-- ID: 4537
-- Item: roast_carp
-- Food Effect: 30Min, All Races
-----------------------------------
-- Dexterity 1
-- Mind -1
-- Ranged ATT % 14 (cap 40)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4537)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.DEX, 1)
    target:addMod(tpz.mod.MND, -1)
    target:addMod(tpz.mod.FOOD_RATTP, 14)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 40)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.DEX, 1)
    target:delMod(tpz.mod.MND, -1)
    target:delMod(tpz.mod.FOOD_RATTP, 14)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 40)
end

return item_object
