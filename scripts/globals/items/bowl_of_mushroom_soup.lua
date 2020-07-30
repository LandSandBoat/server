-----------------------------------------
-- ID: 4419
-- Item: mushroom_soup
-- Food Effect: 3hours, All Races
-----------------------------------------
-- Magic Points 20
-- Strength -1
-- Mind 2
-- MP Recovered While Healing 1
-- Enmity -2
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4419)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MP, 20)
    target:addMod(tpz.mod.STR, -1)
    target:addMod(tpz.mod.MND, 2)
    target:addMod(tpz.mod.MPHEAL, 1)
    target:addMod(tpz.mod.ENMITY, -2)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MP, 20)
    target:delMod(tpz.mod.STR, -1)
    target:delMod(tpz.mod.MND, 2)
    target:delMod(tpz.mod.MPHEAL, 1)
    target:delMod(tpz.mod.ENMITY, -2)
end
