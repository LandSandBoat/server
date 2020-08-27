-----------------------------------------
-- ID: 4467
-- Item: garlic_cracker
-- Food Effect: 3Min, All Races
-----------------------------------------
-- HP Regen While Healing 6
-- Undead Killer 10
-- Blind Resist 10
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 180, 4467)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HPHEAL, 6)
    target:addMod(tpz.mod.UNDEAD_KILLER, 10)
    target:addMod(tpz.mod.BLINDRES, 10)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HPHEAL, 6)
    target:delMod(tpz.mod.UNDEAD_KILLER, 10)
    target:delMod(tpz.mod.BLINDRES, 10)
end
