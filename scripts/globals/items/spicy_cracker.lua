-----------------------------------------
-- ID: 4466
-- Item: spicy_cracker
-- Food Effect: 3Min, All Races
-----------------------------------------
-- HP Recovered While Healing 7
-- Beast Killer +10
-- Resist Sleep +10
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 180, 4466)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HPHEAL, 7)
    target:addMod(tpz.mod.BEAST_KILLER, 10)
    target:addMod(tpz.mod.SLEEPRES, 10)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HPHEAL, 7)
    target:delMod(tpz.mod.BEAST_KILLER, 10)
    target:delMod(tpz.mod.SLEEPRES, 10)
end
