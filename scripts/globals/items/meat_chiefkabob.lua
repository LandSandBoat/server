-----------------------------------
-- ID: 4574
-- Item: meat_chiefkabob
-- Food Effect: 60Min, All Races
-----------------------------------
-- Strength 5
-- Agility 1
-- Intelligence -2
-- Attack % 22
-- Attack Cap 65
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 4574)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.STR, 5)
    target:addMod(tpz.mod.AGI, 1)
    target:addMod(tpz.mod.INT, -2)
    target:addMod(tpz.mod.FOOD_ATTP, 22)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 65)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.STR, 5)
    target:delMod(tpz.mod.AGI, 1)
    target:delMod(tpz.mod.INT, -2)
    target:delMod(tpz.mod.FOOD_ATTP, 22)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 65)
end

return item_object
