-----------------------------------------
-- ID: 5774
-- Item: crepe_forestiere
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Mind 2
-- MP % 10 (cap 35)
-- Magic Accuracy +15
-- Magic Def. Bonus +6
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5774)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.MND, 2)
    target:addMod(tpz.mod.FOOD_MPP, 10)
    target:addMod(tpz.mod.FOOD_MP_CAP, 35)
    target:addMod(tpz.mod.MACC, 15)
    target:addMod(tpz.mod.MDEF, 6)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.MND, 2)
    target:delMod(tpz.mod.FOOD_MPP, 10)
    target:delMod(tpz.mod.FOOD_MP_CAP, 35)
    target:delMod(tpz.mod.MACC, 15)
    target:delMod(tpz.mod.MDEF, 6)
end

return item_object
