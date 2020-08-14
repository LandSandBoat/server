-----------------------------------------
-- ID: 5935
-- Item: Bowl of Moogurt
-- Food Effect: 30Min, All Races
-----------------------------------------
-- HP % 20 Cap 20
-- Vitality 3
-- HP Healing 3
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5935)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 20)
    target:addMod(tpz.mod.FOOD_HP_CAP, 20)
    target:addMod(tpz.mod.VIT, 3)
    target:addMod(tpz.mod.HPHEAL, 3)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 20)
    target:delMod(tpz.mod.FOOD_HP_CAP, 20)
    target:delMod(tpz.mod.VIT, 3)
    target:delMod(tpz.mod.HPHEAL, 3)
end
