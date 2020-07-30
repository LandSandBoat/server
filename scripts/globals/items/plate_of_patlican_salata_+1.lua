-----------------------------------------
-- ID: 5583
-- Item: plate_of_patlican_salata_+1
-- Food Effect: 4Hrs, All Races
-----------------------------------------
-- Agility 5
-- Vitality -2
-- Evasion +7
-- hHP +3
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5583)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.AGI, 5)
    target:addMod(tpz.mod.VIT, -2)
    target:addMod(tpz.mod.EVA, 7)
    target:addMod(tpz.mod.HPHEAL, 3)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.AGI, 5)
    target:delMod(tpz.mod.VIT, -2)
    target:delMod(tpz.mod.EVA, 7)
    target:delMod(tpz.mod.HPHEAL, 3)
end
