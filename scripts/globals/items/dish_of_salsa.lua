-----------------------------------------
-- ID: 5299
-- Item: dish_of_salsa
-- Food Effect: 3Min, All Races
-----------------------------------------
-- Strength -1
-- Dexterity -1
-- Agility -1
-- Vitality -1
-- Intelligence -1
-- Mind -1
-- Sleep Resist 5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 180, 5299)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STR, -1)
    target:addMod(tpz.mod.DEX, -1)
    target:addMod(tpz.mod.AGI, -1)
    target:addMod(tpz.mod.VIT, -1)
    target:addMod(tpz.mod.INT, -1)
    target:addMod(tpz.mod.MND, -1)
    target:addMod(tpz.mod.SLEEPRES, 5)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.STR, -1)
    target:delMod(tpz.mod.DEX, -1)
    target:delMod(tpz.mod.AGI, -1)
    target:delMod(tpz.mod.VIT, -1)
    target:delMod(tpz.mod.INT, -1)
    target:delMod(tpz.mod.MND, -1)
    target:delMod(tpz.mod.SLEEPRES, 5)
end
