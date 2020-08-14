-----------------------------------------
-- ID: 5567
-- Item: dried_date
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Health 10
-- Magic 20
-- Agility -1
-- Intelligence 3
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5567)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 10)
    target:addMod(tpz.mod.MP, 20)
    target:addMod(tpz.mod.AGI, -1)
    target:addMod(tpz.mod.INT, 3)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 10)
    target:delMod(tpz.mod.MP, 20)
    target:delMod(tpz.mod.AGI, -1)
    target:delMod(tpz.mod.INT, 3)
end
