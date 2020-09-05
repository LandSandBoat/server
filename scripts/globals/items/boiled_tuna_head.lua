-----------------------------------------
-- ID: 4540
-- Item: Boiled Tuna Head
-- Food Effect: 180Min, All Races
-----------------------------------------
-- Magic 20
-- Dexterity 3
-- Intelligence 4
-- Mind -3
-- Magic Regen While Healing 2
-- Evasion 5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4540)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MP, 20)
    target:addMod(tpz.mod.DEX, 3)
    target:addMod(tpz.mod.INT, 4)
    target:addMod(tpz.mod.MND, -3)
    target:addMod(tpz.mod.MPHEAL, 2)
    target:addMod(tpz.mod.EVA, 5)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MP, 20)
    target:delMod(tpz.mod.DEX, 3)
    target:delMod(tpz.mod.INT, 4)
    target:delMod(tpz.mod.MND, -3)
    target:delMod(tpz.mod.MPHEAL, 2)
    target:delMod(tpz.mod.EVA, 5)
end
