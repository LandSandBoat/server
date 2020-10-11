-----------------------------------------
-- ID: 4268
-- Item: plate_of_sea_spray_risotto
-- Food Effect: 4Hrs, All Races
-----------------------------------------
-- HP 45
-- Dexterity 6
-- Agility 3
-- Mind -4
-- HP Recovered While Healing 1
-- Accuracy % 6 (cap 20)
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 4268)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.HP, 45)
    target:addMod(tpz.mod.DEX, 6)
    target:addMod(tpz.mod.AGI, 3)
    target:addMod(tpz.mod.MND, -4)
    target:addMod(tpz.mod.HPHEAL, 1)
    target:addMod(tpz.mod.FOOD_ACCP, 6)
    target:addMod(tpz.mod.FOOD_ACC_CAP, 20)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.HP, 45)
    target:delMod(tpz.mod.DEX, 6)
    target:delMod(tpz.mod.AGI, 3)
    target:delMod(tpz.mod.MND, -4)
    target:delMod(tpz.mod.HPHEAL, 1)
    target:delMod(tpz.mod.FOOD_ACCP, 6)
    target:delMod(tpz.mod.FOOD_ACC_CAP, 20)
end
