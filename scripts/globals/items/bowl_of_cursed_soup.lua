-----------------------------------------
-- ID: 4235
-- Item: Bowl of Cursed Soup
-- Food Effect: 240Min, All Races
-----------------------------------------
-- Strength -7
-- Dexterity -7
-- Agility -7
-- Vitality -7
-- Intelligence -7
-- Mind -7
-- Charisma -7
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 4235)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.STR, -7)
    target:addMod(tpz.mod.DEX, -7)
    target:addMod(tpz.mod.AGI, -7)
    target:addMod(tpz.mod.VIT, -7)
    target:addMod(tpz.mod.INT, -7)
    target:addMod(tpz.mod.MND, -7)
    target:addMod(tpz.mod.CHR, -7)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.STR, -7)
    target:delMod(tpz.mod.DEX, -7)
    target:delMod(tpz.mod.AGI, -7)
    target:delMod(tpz.mod.VIT, -7)
    target:delMod(tpz.mod.INT, -7)
    target:delMod(tpz.mod.MND, -7)
    target:delMod(tpz.mod.CHR, -7)
end
