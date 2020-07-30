-----------------------------------------
-- ID: 4281
-- Item: red_hot_cracker
-- Food Effect: 3Min, All Races
-----------------------------------------
-- HP Recovered While Healing 9
-- Beast Killer 12
-- Resist Sleep 12
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 180, 4281)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HPHEAL, 9)
    target:addMod(tpz.mod.BEAST_KILLER, 12)
    target:addMod(tpz.mod.SLEEPRES, 12)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HPHEAL, 9)
    target:delMod(tpz.mod.BEAST_KILLER, 12)
    target:delMod(tpz.mod.SLEEPRES, 12)
end
