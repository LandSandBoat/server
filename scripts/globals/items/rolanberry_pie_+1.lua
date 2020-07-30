-----------------------------------------
-- ID: 4339
-- Item: rolanberry_pie_+1
-- Food Effect: 60Min, All Races
-----------------------------------------
-- Magic 60
-- Intelligence 3
-- MP Regen While Healing 1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 4339)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MP, 60)
    target:addMod(tpz.mod.INT, 3)
    target:addMod(tpz.mod.MPHEAL, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MP, 60)
    target:delMod(tpz.mod.INT, 3)
    target:delMod(tpz.mod.MPHEAL, 1)
end
