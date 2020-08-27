-----------------------------------------
-- ID: 4394
-- Item: ginger_cookie
-- Food Effect: 3Min, All Races
-----------------------------------------
-- Magic Regen While Healing 5
-- Plantoid Killer 10
-- Slow Resist 10
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 180, 4394)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MPHEAL, 5)
    target:addMod(tpz.mod.PLANTOID_KILLER, 10)
    target:addMod(tpz.mod.SLOWRES, 10)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MPHEAL, 5)
    target:delMod(tpz.mod.PLANTOID_KILLER, 10)
    target:delMod(tpz.mod.SLOWRES, 10)
end
