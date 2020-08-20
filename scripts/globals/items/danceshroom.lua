-----------------------------------------
-- ID: 4375
-- Item: danceshroom
-- Food Effect: 5Min, All Races
-----------------------------------------
-- Strength -5
-- Mind 3
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 4375)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STR, -5)
    target:addMod(tpz.mod.MND, 3)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.STR, -5)
    target:delMod(tpz.mod.MND, 3)
end
