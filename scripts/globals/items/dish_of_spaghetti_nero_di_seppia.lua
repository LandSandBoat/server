-----------------------------------------
-- ID: 5193
-- Item: dish_of_spaghetti_nero_di_seppia
-- Food Effect: 30Min, All Races
-----------------------------------------
-- HP % 17 (cap 130)
-- Dexterity 3
-- Vitality 2
-- Agility -1
-- Mind -2
-- Charisma -1
-- Double Attack 1
-- Store TP 6
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5193)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_HPP, 17)
    target:addMod(tpz.mod.FOOD_HP_CAP, 130)
    target:addMod(tpz.mod.DEX, 3)
    target:addMod(tpz.mod.VIT, 2)
    target:addMod(tpz.mod.AGI, -1)
    target:addMod(tpz.mod.MND, -2)
    target:addMod(tpz.mod.CHR, -1)
    target:addMod(tpz.mod.DOUBLE_ATTACK, 1)
    target:addMod(tpz.mod.STORETP, 6)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_HPP, 17)
    target:delMod(tpz.mod.FOOD_HP_CAP, 130)
    target:delMod(tpz.mod.DEX, 3)
    target:delMod(tpz.mod.VIT, 2)
    target:delMod(tpz.mod.AGI, -1)
    target:delMod(tpz.mod.MND, -2)
    target:delMod(tpz.mod.CHR, -1)
    target:delMod(tpz.mod.DOUBLE_ATTACK, 1)
    target:delMod(tpz.mod.STORETP, 6)
end
