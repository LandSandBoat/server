-----------------------------------------
-- ID: 4603
-- Item: cup_of_chamomile_tea
-- Food Effect: 180Min, All Races
-----------------------------------------
-- Magic 8
-- Vitality -2
-- Charisma 2
-- Magic Regen While Healing 1
-- Sleep resistance -30
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4603)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MP, 8)
    target:addMod(tpz.mod.VIT, -2)
    target:addMod(tpz.mod.CHR, 2)
    target:addMod(tpz.mod.MPHEAL, 1)
    target:addMod(tpz.mod.SLEEPRES, -30)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MP, 8)
    target:delMod(tpz.mod.VIT, -2)
    target:delMod(tpz.mod.CHR, 2)
    target:delMod(tpz.mod.MPHEAL, 1)
    target:delMod(tpz.mod.SLEEPRES, -30)
end
