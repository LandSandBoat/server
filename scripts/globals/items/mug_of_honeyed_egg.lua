-----------------------------------------
-- ID: 5739
-- Item: mug_of_honeyed_egg
-- Food Effect: 30Min, All Races
-----------------------------------------
-- MP 8
-- Intelligence 1
-- MP recovered while healing 1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5739)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MP, 8)
    target:addMod(tpz.mod.INT, 1)
    target:addMod(tpz.mod.MPHEAL, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MP, 8)
    target:delMod(tpz.mod.INT, 1)
    target:delMod(tpz.mod.MPHEAL, 1)
end
