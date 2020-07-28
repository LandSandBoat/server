-----------------------------------------
-- ID: 4280
-- Item: garlic_cracker_+1
-- Food Effect: 5Min, All Races
-----------------------------------------
-- HP recovered while healing +8
-- Undead Killer +12
-- Blind Resist +12
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 4280)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HPHEAL, 8)
    target:addMod(tpz.mod.UNDEAD_KILLER, 12)
    target:addMod(tpz.mod.BLINDRES, 12)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HPHEAL, 8)
    target:delMod(tpz.mod.UNDEAD_KILLER, 12)
    target:delMod(tpz.mod.BLINDRES, 12)
end
