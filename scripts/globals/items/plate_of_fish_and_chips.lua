-----------------------------------------
-- ID: 5145
-- Item: plate_of_fish_and_chips
-- Food Effect: 180Min, All Races
-----------------------------------------
-- Dexterity 3
-- Vitality 3
-- Mind -3
-- defense 5
-- Ranged ATT % 7
-- Ranged ATT Cap 10
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5145)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.DEX, 3)
    target:addMod(tpz.mod.VIT, 3)
    target:addMod(tpz.mod.MND, -3)
    target:addMod(tpz.mod.DEF, 5)
    target:addMod(tpz.mod.FOOD_RATTP, 7)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 10)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.DEX, 3)
    target:delMod(tpz.mod.VIT, 3)
    target:delMod(tpz.mod.MND, -3)
    target:delMod(tpz.mod.DEF, 5)
    target:delMod(tpz.mod.FOOD_RATTP, 7)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 10)
end

return item_object
