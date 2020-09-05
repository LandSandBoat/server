-----------------------------------------
-- ID: 5940
-- Item: Trail Cookie
-- Food Effect: 5Min, All Races
-----------------------------------------
-- MP Healing 5
-- Aquan Killer 12
-- Sleep Resist 10
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 5940)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MPHEAL, 5)
    target:addMod(tpz.mod.AQUAN_KILLER, 12)
    target:addMod(tpz.mod.SLEEPRES, 10)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MPHEAL, 5)
    target:delMod(tpz.mod.AQUAN_KILLER, 12)
    target:delMod(tpz.mod.SLEEPRES, 10)
end
