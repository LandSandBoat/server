-----------------------------------------
-- ID: 5704
-- Item: anglers_cassoulet
-- Food Effect: 30, All Races
-----------------------------------------
-- VIT -1
-- AGI +5
-- Ranged Accuracy +1
-- Regen +1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5704)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.REGEN, 1)
    target:addMod(tpz.mod.VIT, -1)
    target:addMod(tpz.mod.AGI, 5)
    target:addMod(tpz.mod.RACC, 5)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.REGEN, 1)
    target:delMod(tpz.mod.VIT, -1)
    target:delMod(tpz.mod.AGI, 5)
    target:delMod(tpz.mod.RACC, 5)
end
