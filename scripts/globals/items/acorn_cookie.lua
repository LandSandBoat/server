-----------------------------------------
-- ID: 4510
-- Item: Acorn Cookie
-- Food Effect: 3Min, All Races
-----------------------------------------
-- Aquan killer +10
-- Silence resistance +10
-- MP recovered while healing +3
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 180, 4510)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.AQUAN_KILLER, 10)
    target:addMod(tpz.mod.SILENCERES, 10)
    target:addMod(tpz.mod.MPHEAL, 3)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.AQUAN_KILLER, 10)
    target:delMod(tpz.mod.SILENCERES, 10)
    target:delMod(tpz.mod.MPHEAL, 3)
end
