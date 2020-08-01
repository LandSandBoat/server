-----------------------------------------
-- ID: 4523
-- Item: melon_pie_+1
-- Food Effect: 60Min, All Races
-----------------------------------------
-- Magic 30
-- Intelligence 5
-- Magic Regen While Healing 2
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 4523)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MP, 30)
    target:addMod(tpz.mod.INT, 5)
    target:addMod(tpz.mod.MPHEAL, 2)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MP, 30)
    target:delMod(tpz.mod.INT, 5)
    target:delMod(tpz.mod.MPHEAL, 2)
end
