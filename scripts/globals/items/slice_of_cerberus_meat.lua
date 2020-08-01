-----------------------------------------
-- ID: 5565
-- Item: slice_of_cerberus_meat
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Health 10
-- Magic -10
-- Strength 6
-- Intelligence -6
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if (target:getRace() ~= tpz.race.GALKA) then
        result = tpz.msg.basic.CANNOT_EAT
    end
    if (target:getMod(tpz.mod.EAT_RAW_MEAT) == 1) then
        result = 0
    end
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5565)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 10)
    target:addMod(tpz.mod.MP, -10)
    target:addMod(tpz.mod.STR, 6)
    target:addMod(tpz.mod.INT, -6)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 10)
    target:delMod(tpz.mod.MP, -10)
    target:delMod(tpz.mod.STR, 6)
    target:delMod(tpz.mod.INT, -6)
end
