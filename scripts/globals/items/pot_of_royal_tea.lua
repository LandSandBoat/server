-----------------------------------------
-- ID: 4524
-- Item: pot_of_royal_tea
-- Food Effect: 240Min, All Races
-----------------------------------------
-- Vitality -1
-- Charisma 3
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 4524)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.VIT, -1)
    target:addMod(tpz.mod.CHR, 3)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.VIT, -1)
    target:delMod(tpz.mod.CHR, 3)
end
