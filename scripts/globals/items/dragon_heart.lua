-----------------------------------------
-- ID: 4486
-- Item: Dragon Heart
-- Food Effect: 3 Hr, Galka Only
-----------------------------------------
-- Strength 7
-- Intelligence -9
-- MP -40
-- HP 40
-- Dragon Killer 10
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4486)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STR, 7)
    target:addMod(tpz.mod.INT, -9)
    target:addMod(tpz.mod.MP, -40)
    target:addMod(tpz.mod.HP, 40)
    target:addMod(tpz.mod.DRAGON_KILLER, 10)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.STR, 7)
    target:delMod(tpz.mod.INT, -9)
    target:delMod(tpz.mod.MP, -40)
    target:delMod(tpz.mod.HP, 40)
    target:delMod(tpz.mod.DRAGON_KILLER, 10)
end
