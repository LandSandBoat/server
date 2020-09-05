-----------------------------------------
-- ID: 5976
-- Item: Bowl of Ulbuconut Milk
-- Food Effect: 3Min, All Races
-----------------------------------------
-- Charisma +3
-- Vitality -2
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 180, 5976)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.CHR, 3)
    target:addMod(tpz.mod.VIT, -2)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.CHR, 3)
    target:delMod(tpz.mod.VIT, -2)
end
