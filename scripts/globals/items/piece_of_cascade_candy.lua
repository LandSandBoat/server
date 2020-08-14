-----------------------------------------
-- ID: 5942
-- Item: Piece of Cascade Candy
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Mind +4
-- Charisma +4
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5942)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.MND, 4)
    target:addMod(tpz.mod.CHR, 4)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.MND, 4)
    target:delMod(tpz.mod.CHR, 4)
end
