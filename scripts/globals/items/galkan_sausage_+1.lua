-----------------------------------------
-- ID: 5859
-- Item: galkan_sausage_+1
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Strength 4
-- Intelligence -5
-- Attack 10
-- Ranged Attack 10
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5859)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STR, 4)
    target:addMod(tpz.mod.INT, -5)
    target:addMod(tpz.mod.ATT, 10)
    target:addMod(tpz.mod.RATT, 10)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.STR, 4)
    target:delMod(tpz.mod.INT, -5)
    target:delMod(tpz.mod.ATT, 10)
    target:delMod(tpz.mod.RATT, 10)
end
