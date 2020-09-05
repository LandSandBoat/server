-----------------------------------------
-- ID: 5755
-- Item: Slab of Ruszor Meat
-- Food Effect: 30Min, Galka only
-----------------------------------------
-- Strength 5
-- Intelligence -7
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5755)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STR, 5)
    target:addMod(tpz.mod.INT, -7)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.STR, 5)
    target:delMod(tpz.mod.INT, -7)
end
