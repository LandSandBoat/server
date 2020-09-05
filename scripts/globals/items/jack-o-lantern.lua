-----------------------------------------
-- ID: 4488
-- Item: jack-o-lantern
-- Food Effect: 180Min, All Races
-----------------------------------------
-- Charisma -10
-- Accuracy 10
-- Ranged Acc 10
-- Evasion 10
-- Arcana Killer 4
-- Dark Res 25
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4488)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.CHR, -10)
    target:addMod(tpz.mod.ACC, 10)
    target:addMod(tpz.mod.RACC, 10)
    target:addMod(tpz.mod.EVA, 10)
    target:addMod(tpz.mod.ARCANA_KILLER, 4)
    target:addMod(tpz.mod.DARKRES, 25)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.CHR, -10)
    target:delMod(tpz.mod.ACC, 10)
    target:delMod(tpz.mod.RACC, 10)
    target:delMod(tpz.mod.EVA, 10)
    target:delMod(tpz.mod.ARCANA_KILLER, 4)
    target:delMod(tpz.mod.DARKRES, 25)
end
