-----------------------------------------
-- ID: 4404
-- Item: roast_trout
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Dexterity 3
-- Mind -1
-- Ranged ATT % 14 (cap 50)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4404)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.DEX, 3)
    target:addMod(tpz.mod.MND, -1)
    target:addMod(tpz.mod.RATTP, 14)
    target:addMod(tpz.mod.RATT_CAP, 50)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.DEX, 3)
    target:delMod(tpz.mod.MND, -1)
    target:delMod(tpz.mod.RATTP, 14)
    target:delMod(tpz.mod.RATT_CAP, 50)
end
