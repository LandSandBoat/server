-----------------------------------------
-- ID: 4270
-- Item: sweet_rice_cake
-- Food Effect: 30Min, All Races
-----------------------------------------
-- MP 17
-- Vitality 2
-- Intelligence 3
-- Mind 1
-- HP Recovered While Healing 2
-- MP Recovered While Healing 2
-- Evasion 5
-- Resist Silence 4
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4270)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MP, 17)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.INT, 3)
    target:addMod(tpz.mod.MND, 1)
    target:addMod(tpz.mod.HPHEAL, 2)
    target:addMod(tpz.mod.MPHEAL, 2)
    target:addMod(tpz.mod.EVA, 5)
    target:addMod(tpz.mod.SILENCERES, 4)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MP, 17)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.INT, 3)
    target:delMod(tpz.mod.MND, 1)
    target:delMod(tpz.mod.HPHEAL, 2)
    target:delMod(tpz.mod.MPHEAL, 2)
    target:delMod(tpz.mod.EVA, 5)
    target:delMod(tpz.mod.SILENCERES, 4)
end
