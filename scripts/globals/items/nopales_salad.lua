-----------------------------------------
-- ID: 5701
-- Item: nopales_salad
-- Food Effect: 3Hrs, All Races
-----------------------------------------
-- Strength 1
-- Agility 6
-- Ranged Accuracy +20
-- Ranged Attack +10
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5701)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STR, 1)
    target:addMod(tpz.mod.AGI, 6)
    target:addMod(tpz.mod.RACC, 20)
    target:addMod(tpz.mod.RATT, 10)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.STR, 1)
    target:delMod(tpz.mod.AGI, 6)
    target:delMod(tpz.mod.RACC, 20)
    target:delMod(tpz.mod.RATT, 10)
end
