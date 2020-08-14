-----------------------------------------
-- ID: 5732
-- Item: plate_of_ratatouille_+1
-- Food Effect: 4Hrs, All Races
-----------------------------------------
-- Agility 6
-- Evasion 10
-- HP recovered while healing 3
-- MP recovered while healing 3
-- Undead Killer 10
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5732)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.AGI, 6)
    target:addMod(tpz.mod.EVA, 10)
    target:addMod(tpz.mod.HPHEAL, 3)
    target:addMod(tpz.mod.MPHEAL, 3)
    target:addMod(tpz.mod.UNDEAD_KILLER, 10)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.AGI, 6)
    target:delMod(tpz.mod.EVA, 10)
    target:delMod(tpz.mod.HPHEAL, 3)
    target:delMod(tpz.mod.MPHEAL, 3)
    target:delMod(tpz.mod.UNDEAD_KILLER, 10)
end
