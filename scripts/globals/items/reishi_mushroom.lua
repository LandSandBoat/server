-----------------------------------------
-- ID: 4449
-- Item: reishi_mushroom
-- Food Effect: 5Min, All Races
-----------------------------------------
-- Strength -6
-- Mind 4
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 4449)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STR, -6)
    target:addMod(tpz.mod.MND, 4)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.STR, -6)
    target:delMod(tpz.mod.MND, 4)
end
