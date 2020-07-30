-----------------------------------------
-- ID: 4343
-- Item: witch_kabob
-- Food Effect: 1hour, All Races
-----------------------------------------
-- Magic Points 15
-- Mind 4
-- Enmity -1
-- MP Recovered While Healing 3
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 4343)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MP, 15)
    target:addMod(tpz.mod.MND, 4)
    target:addMod(tpz.mod.ENMITY, -1)
    target:addMod(tpz.mod.MPHEAL, 3)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MP, 15)
    target:delMod(tpz.mod.MND, 4)
    target:delMod(tpz.mod.ENMITY, -1)
    target:delMod(tpz.mod.MPHEAL, 3)
end
