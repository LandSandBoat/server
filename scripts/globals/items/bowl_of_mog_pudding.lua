-----------------------------------------
-- ID: 6009
-- Item: Bowl of Mog Pudding
-- Food Effect: 30Min, All Races
-----------------------------------------
-- HP 7
-- MP 7
-- Vitality 3
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 6009)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 7)
    target:addMod(tpz.mod.MP, 7)
    target:addMod(tpz.mod.VIT, 3)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 7)
    target:delMod(tpz.mod.MP, 7)
    target:delMod(tpz.mod.VIT, 3)
end
