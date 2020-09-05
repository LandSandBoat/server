-----------------------------------------
-- ID: 5646
-- Item: handful_of_bloody_chocolate
-- Food Effect: 1hour, All Races
-----------------------------------------
-- MP Recovered While Healing 4
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 5646)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MPHEAL, 4)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MPHEAL, 4)
end
