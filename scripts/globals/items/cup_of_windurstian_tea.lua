-----------------------------------------
-- ID: 4493
-- Item: cup_of_windurstian_tea
-- Food Effect: 180Min, All Races
-----------------------------------------
-- Vitality -2
-- Charisma 1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4493)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.VIT, -2)
    target:addMod(tpz.mod.CHR, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.VIT, -2)
    target:delMod(tpz.mod.CHR, 1)
end
