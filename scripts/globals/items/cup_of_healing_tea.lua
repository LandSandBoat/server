-----------------------------------------
-- ID: 4286
-- Item: cup_of_healing_tea
-- Food Effect: 240Min, All Races
-----------------------------------------
-- Magic 10
-- Vitality -1
-- Charisma 3
-- Magic Regen While Healing 2
-- Sleep resistance -40
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 4286)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MP, 10)
    target:addMod(tpz.mod.VIT, -1)
    target:addMod(tpz.mod.CHR, 3)
    target:addMod(tpz.mod.MPHEAL, 2)
    target:addMod(tpz.mod.SLEEPRES, -40)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MP, 10)
    target:delMod(tpz.mod.VIT, -1)
    target:delMod(tpz.mod.CHR, 3)
    target:delMod(tpz.mod.MPHEAL, 2)
    target:delMod(tpz.mod.SLEEPRES, -40)
end
