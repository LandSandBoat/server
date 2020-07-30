-----------------------------------------
-- ID: 5675
-- Item: Withered Rolanberry
-- Food Effect: 30 Mins, All Races
-----------------------------------------
-- Intelligence 1
-- Agility -3
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5675)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.INT, 1)
    target:addMod(tpz.mod.AGI, -3)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.INT, 1)
    target:delMod(tpz.mod.AGI, -3)
end
