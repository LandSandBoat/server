-----------------------------------------
-- ID: 4602
-- Item: warm_egg
-- Food Effect: 5Min, All Races
-----------------------------------------
-- Health 18
-- Magic 18
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 4602)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 18)
    target:addMod(tpz.mod.MP, 18)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 18)
    target:delMod(tpz.mod.MP, 18)
end
