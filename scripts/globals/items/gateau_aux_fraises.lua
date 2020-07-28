-----------------------------------------
-- ID: 5542
-- Item: Gateau aux fraises
-- Food Effect: 3 Hrs, All Races
-----------------------------------------
-- TODO: Group Effect
-- HP 8
-- MP 8% Cap 50
-- Intelligence 1
-- HP Recovered while healing 1
-- MP Recovered while healing 1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5542)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 8)
    target:addMod(tpz.mod.INT, 1)
    target:addMod(tpz.mod.FOOD_MPP, 8)
    target:addMod(tpz.mod.FOOD_MP_CAP, 50)
    target:addMod(tpz.mod.HPHEAL, 1)
    target:addMod(tpz.mod.MPHEAL, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 8)
    target:delMod(tpz.mod.INT, 1)
    target:delMod(tpz.mod.FOOD_MPP, 8)
    target:delMod(tpz.mod.FOOD_MP_CAP, 50)
    target:delMod(tpz.mod.HPHEAL, 1)
    target:delMod(tpz.mod.MPHEAL, 1)
end
