-----------------------------------------
-- ID: 4408
-- Item: tortilla
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Health 6
-- Dexterity -1
-- Vitality 4
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4408)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 6)
    target:addMod(tpz.mod.DEX, -1)
    target:addMod(tpz.mod.VIT, 4)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 6)
    target:delMod(tpz.mod.DEX, -1)
    target:delMod(tpz.mod.VIT, 4)
end
