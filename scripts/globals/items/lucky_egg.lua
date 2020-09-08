-----------------------------------------
-- ID: 4600
-- Item: lucky_egg
-- Food Effect: 60Min, All Races
-----------------------------------------
-- Health 14
-- Magic 14
-- Evasion 10
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 4600)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 14)
    target:addMod(tpz.mod.MP, 14)
    target:addMod(tpz.mod.EVA, 10)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 14)
    target:delMod(tpz.mod.MP, 14)
    target:delMod(tpz.mod.EVA, 10)
end
