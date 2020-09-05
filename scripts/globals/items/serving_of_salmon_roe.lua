-----------------------------------------
-- ID: 5218
-- Item: serving_of_salmon_roe
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Health 8
-- Magic 8
-- Dexterity 2
-- Mind -1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5218)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 8)
    target:addMod(tpz.mod.MP, 8)
    target:addMod(tpz.mod.DEX, 2)
    target:addMod(tpz.mod.MND, -1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 8)
    target:delMod(tpz.mod.MP, 8)
    target:delMod(tpz.mod.DEX, 2)
    target:delMod(tpz.mod.MND, -1)
end
