-----------------------------------------
-- ID: 4380
-- Item: smoked_salmon
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Dexterity 2
-- Mind -3
-- Ranged Accuracy +1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4380)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.DEX, 2)
    target:addMod(tpz.mod.MND, -3)
    target:addMod(tpz.mod.RACC, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.DEX, 2)
    target:delMod(tpz.mod.MND, -3)
    target:delMod(tpz.mod.RACC, 1)
end
