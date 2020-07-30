-----------------------------------------
-- ID: 5760
-- Item: kohlrouladen
-- Food Effect: 3hr, All Races
-----------------------------------------
-- Strength 3
-- Agility 3
-- Intelligence -5
-- RACC +8% (cap 60)
-- RATT +14% (cap 65)
-- Enmity -4
-- Subtle Blow +5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5760)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STR, 3)
    target:addMod(tpz.mod.AGI, 3)
    target:addMod(tpz.mod.INT, -5)
    target:addMod(tpz.mod.FOOD_RACCP, 8)
    target:addMod(tpz.mod.FOOD_RACC_CAP, 60)
    target:addMod(tpz.mod.FOOD_RATTP, 14)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 65)
    target:addMod(tpz.mod.ENMITY, -4)
    target:addMod(tpz.mod.SUBTLE_BLOW, 5)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.STR, 3)
    target:delMod(tpz.mod.AGI, 3)
    target:delMod(tpz.mod.INT, -5)
    target:delMod(tpz.mod.FOOD_RACCP, 8)
    target:delMod(tpz.mod.FOOD_RACC_CAP, 60)
    target:delMod(tpz.mod.FOOD_RATTP, 14)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 65)
    target:delMod(tpz.mod.ENMITY, -4)
    target:delMod(tpz.mod.SUBTLE_BLOW, 5)
end
