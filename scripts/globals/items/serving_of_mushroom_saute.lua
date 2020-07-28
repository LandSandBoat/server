-----------------------------------------
-- ID: 5676
-- Item: serving_of_mushroom_sautee
-- Food Effect: 3Hrs, All Races
-----------------------------------------
-- MP 60
-- Mind 6
-- MP Recovered While Healing 6
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5676)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MP, 60)
    target:addMod(tpz.mod.MND, 6)
    target:addMod(tpz.mod.MPHEAL, 6)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MP, 60)
    target:delMod(tpz.mod.MND, 6)
    target:delMod(tpz.mod.MPHEAL, 6)
end
