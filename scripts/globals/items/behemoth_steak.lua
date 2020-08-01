-----------------------------------------
-- ID: 6464
-- Item: behemoth_steak
-- Food Effect: 180Min, All Races
-----------------------------------------
-- HP +40
-- STR +7
-- DEX +7
-- INT -3
-- Attack +23% (cap 160)
-- Ranged Attack +23% (cap 160)
-- Triple Attack +1%
-- Lizard Killer +4
-- hHP +4
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 6464)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 40)
    target:addMod(tpz.mod.STR, 7)
    target:addMod(tpz.mod.DEX, 7)
    target:addMod(tpz.mod.INT, -3)
    target:addMod(tpz.mod.FOOD_ATTP, 23)
    target:addMod(tpz.mod.FOOD_ATT_CAP, 160)
    target:addMod(tpz.mod.FOOD_RATTP, 23)
    target:addMod(tpz.mod.FOOD_RATT_CAP, 160)
    target:addMod(tpz.mod.TRIPLE_ATTACK, 1)
    target:addMod(tpz.mod.LIZARD_KILLER, 4)
    target:addMod(tpz.mod.HPHEAL, 4)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 40)
    target:delMod(tpz.mod.STR, 7)
    target:delMod(tpz.mod.DEX, 7)
    target:delMod(tpz.mod.INT, -3)
    target:delMod(tpz.mod.FOOD_ATTP, 23)
    target:delMod(tpz.mod.FOOD_ATT_CAP, 160)
    target:delMod(tpz.mod.FOOD_RATTP, 23)
    target:delMod(tpz.mod.FOOD_RATT_CAP, 160)
    target:delMod(tpz.mod.TRIPLE_ATTACK, 1)
    target:delMod(tpz.mod.LIZARD_KILLER, 4)
    target:delMod(tpz.mod.HPHEAL, 4)
end
