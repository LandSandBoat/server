-----------------------------------------
-- ID: 4414
-- Item: rolanberry_pie
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Magic 50
-- Agility -1
-- Intelligence 2
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4414)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MP, 50)
    target:addMod(tpz.mod.AGI, -1)
    target:addMod(tpz.mod.INT, 2)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MP, 50)
    target:delMod(tpz.mod.AGI, -1)
    target:delMod(tpz.mod.INT, 2)
end
