-----------------------------------------
-- ID: 5563
-- Item: Chunk of Orobon Meat
-- Effect: 5 Minutes, food effect, Galka Only
-----------------------------------------
-- HP 10
-- MP -10
-- Strength +6
-- Intelligence -8
-- Demon Killer 10
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if (target:getRace() ~= tpz.race.GALKA) then
        result = tpz.msg.basic.CANNOT_EAT
    end
    if (target:getMod(tpz.mod.EAT_RAW_MEAT) == 1) then
        result = 0
    end
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 5563)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 10)
    target:addMod(tpz.mod.MP, -10)
    target:addMod(tpz.mod.STR, 6)
    target:addMod(tpz.mod.INT, -8)
    target:addMod(tpz.mod.DEMON_KILLER, 10)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 10)
    target:delMod(tpz.mod.MP, -10)
    target:delMod(tpz.mod.STR, 6)
    target:delMod(tpz.mod.INT, -8)
    target:delMod(tpz.mod.DEMON_KILLER, 10)
end
