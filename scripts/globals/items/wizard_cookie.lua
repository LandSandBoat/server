-----------------------------------------
-- ID: 4576
-- Item: wizard_cookie
-- Food Effect: 5Min, All Races
-----------------------------------------
-- MP Recovered While Healing 7
-- Plantoid Killer 12
-- Slow Resist 12
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 4576)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MPHEAL, 7)
    target:addMod(tpz.mod.PLANTOID_KILLER, 12)
    target:addMod(tpz.mod.SLOWRES, 12)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MPHEAL, 7)
    target:delMod(tpz.mod.PLANTOID_KILLER, 12)
    target:delMod(tpz.mod.SLOWRES, 12)
end
