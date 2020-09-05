-----------------------------------------
-- ID: 5143
-- Item: serving_of_goblin_stir-fry
-- Food Effect: 180Min, All Races
-----------------------------------------
-- Agility 5
-- Vitality 2
-- Charisma -5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5143)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.AGI, 5)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.CHR, -5)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.AGI, 5)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.CHR, -5)
end
