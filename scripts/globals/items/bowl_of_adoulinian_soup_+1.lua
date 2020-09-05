-----------------------------------------
-- ID: 5999
-- Item: Bowl of Adoulin Soup +1
-- Food Effect: 240 Min, All Races
-----------------------------------------
-- HP % 4 Cap 45
-- Vitality 4
-- Defense % 16 Cap 75
-- HP Healing 7
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5999)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 4)
    target:addMod(tpz.mod.FOOD_HP_CAP, 45)
    target:addMod(tpz.mod.VIT, 4)
    target:addMod(tpz.mod.FOOD_DEFP, 16)
    target:addMod(tpz.mod.FOOD_DEF_CAP, 75)
    target:addMod(tpz.mod.HPHEAL, 7)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 4)
    target:delMod(tpz.mod.FOOD_HP_CAP, 45)
    target:delMod(tpz.mod.VIT, 4)
    target:delMod(tpz.mod.FOOD_DEFP, 16)
    target:delMod(tpz.mod.FOOD_DEF_CAP, 75)
    target:delMod(tpz.mod.HPHEAL, 7)
end
