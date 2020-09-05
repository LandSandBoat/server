-----------------------------------------
-- ID: 5730
-- Item: Serving of Bavarois +1
-- Food Effect: 4 Hrs, All Races
-----------------------------------------
-- HP 25
-- Intelligence 4
-- hHP +4
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5730)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 25)
    target:addMod(tpz.mod.INT, 4)
    target:addMod(tpz.mod.HPHEAL, 4)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 25)
    target:delMod(tpz.mod.INT, 4)
    target:delMod(tpz.mod.HPHEAL, 4)
end
