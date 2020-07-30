-----------------------------------------
-- ID: 4595
-- Item: party_egg
-- Food Effect: 60Min, All Races
-----------------------------------------
-- Health 25
-- Magic 25
-- Attack 5
-- Ranged Attack 4
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 3600, 4595)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 25)
    target:addMod(tpz.mod.MP, 25)
    target:addMod(tpz.mod.ATT, 5)
    target:addMod(tpz.mod.RATT, 4)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 25)
    target:delMod(tpz.mod.MP, 25)
    target:delMod(tpz.mod.ATT, 5)
    target:delMod(tpz.mod.RATT, 4)
end
