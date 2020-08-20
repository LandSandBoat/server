-----------------------------------------
-- ID: 5907
-- Item: Winterflower
-- Food Effect: 5Min, All Races
-----------------------------------------
-- Agility +3
-- Intelligence +5
-- Charisma -5
-- Resist Virus +20
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 5907)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.AGI, 3)
    target:addMod(tpz.mod.INT, 5)
    target:addMod(tpz.mod.CHR, -5)
    target:addMod(tpz.mod.VIRUSRES, 20)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.AGI, 3)
    target:delMod(tpz.mod.INT, 5)
    target:delMod(tpz.mod.CHR, -5)
    target:delMod(tpz.mod.VIRUSRES, 20)
end
