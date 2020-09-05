-----------------------------------------
-- ID: 5586
-- Item: serving_of_menemen
-- Food Effect: 3Hrs, All Races
-----------------------------------------
-- HP 30
-- MP 30
-- Agility 1
-- Intelligence -1
-- HP recovered while healing 1
-- MP recovered while healing 1
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5586)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 30)
    target:addMod(tpz.mod.MP, 30)
    target:addMod(tpz.mod.AGI, 1)
    target:addMod(tpz.mod.INT, -1)
    target:addMod(tpz.mod.HPHEAL, 1)
    target:addMod(tpz.mod.MPHEAL, 1)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 30)
    target:delMod(tpz.mod.MP, 30)
    target:delMod(tpz.mod.AGI, 1)
    target:delMod(tpz.mod.INT, -1)
    target:delMod(tpz.mod.HPHEAL, 1)
    target:delMod(tpz.mod.MPHEAL, 1)
end
