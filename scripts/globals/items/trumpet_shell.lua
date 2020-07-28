-----------------------------------------
-- ID: 5466
-- Item: Trumpet Shell
-- Food Effect: 5Min, Mithra only
-----------------------------------------
-- Dexterity -5
-- Vitality 4
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if (target:getRace() ~= tpz.race.MITHRA) then
        result = tpz.msg.basic.CANNOT_EAT
    end
    if (target:getMod(tpz.mod.EAT_RAW_FISH) == 1) then
        result = 0
    end
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

function onItemUse(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 5466)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.DEX, -5)
    target:addMod(tpz.mod.VIT, 4)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.DEX, -5)
    target:delMod(tpz.mod.VIT, 4)
end
