-----------------------------------------
-- ID: 5772
-- Item: crepe_paysanne
-- Food Effect: 30 Min, All Races
-----------------------------------------
-- HP +10% (cap 30)
-- STR +2
-- VIT +1
-- Magic Accuracy +15
-- Magic Defense +4
-- hHP +3
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5772)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 10)
    target:addMod(tpz.mod.FOOD_HP_CAP, 30)
    target:addMod(tpz.mod.STR, 2)
    target:addMod(tpz.mod.VIT, 1)
    target:addMod(tpz.mod.MACC, 15)
    target:addMod(tpz.mod.MDEF, 4)
    target:addMod(tpz.mod.HPHEAL, 3)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 10)
    target:delMod(tpz.mod.FOOD_HP_CAP, 30)
    target:delMod(tpz.mod.STR, 2)
    target:delMod(tpz.mod.VIT, 1)
    target:delMod(tpz.mod.MACC, 15)
    target:delMod(tpz.mod.MDEF, 4)
    target:delMod(tpz.mod.HPHEAL, 3)
end

return item_object
