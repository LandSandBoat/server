-----------------------------------------
-- ID: 5628
-- Item: Silken Smile
-- Food Effect: 4 Hrs, All Races
-----------------------------------------
-- TODO: Group Effect
-- Intelligence 2
-- HP Recovered while healing 4
-- MP Recovered while healing 7
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5628)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.INT, 2)
    target:addMod(tpz.mod.HPHEAL, 4)
    target:addMod(tpz.mod.MPHEAL, 7)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.INT, 2)
    target:delMod(tpz.mod.HPHEAL, 4)
    target:delMod(tpz.mod.MPHEAL, 7)
end
