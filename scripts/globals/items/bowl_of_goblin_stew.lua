-----------------------------------------
-- ID: 4465
-- Item: bowl_of_goblin_stew
-- Food Effect: 3Hrs, All Races
-----------------------------------------
-- Dexterity -4
-- Attack +16% (cap 80)
-- Ranged Attack +16% (cap 80)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4465)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.DEX, -4)
    target:addMod(tpz.mod.FOOD_ATTP, 16)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 80)
    target:addMod(tpz.mod.FOOD_RATTP, 16)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 80)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.DEX, -4)
    target:delMod(tpz.mod.FOOD_ATTP, 16)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 80)
    target:delMod(tpz.mod.FOOD_RATTP, 16)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 80)
end

return item_object
