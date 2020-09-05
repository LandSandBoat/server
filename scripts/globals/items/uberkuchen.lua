-----------------------------------------
-- ID: 5615
-- Item: uberkuchen
-- Food Effect: 4Hrs, All Races
-----------------------------------------
-- HP 10
-- MP % 3 (cap 15)
-- Intelligence 3
-- HP Recovered While Healing 2
-- MP Recovered While Healing 1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5615)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 10)
    target:addMod(tpz.mod.FOOD_MPP, 3)
    target:addMod(tpz.mod.FOOD_MP_CAP, 15)
    target:addMod(tpz.mod.HPHEAL, 2)
    target:addMod(tpz.mod.MPHEAL, 1)
    target:addMod(tpz.mod.INT, 3)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 10)
    target:delMod(tpz.mod.FOOD_MPP, 3)
    target:delMod(tpz.mod.FOOD_MP_CAP, 15)
    target:delMod(tpz.mod.HPHEAL, 2)
    target:delMod(tpz.mod.MPHEAL, 1)
    target:delMod(tpz.mod.INT, 3)
end
