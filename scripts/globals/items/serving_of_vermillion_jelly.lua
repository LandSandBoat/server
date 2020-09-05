-----------------------------------------
-- ID: 5158
-- Item: Vermillion Jelly
-- Food Effect: 4 hours, All Races
-----------------------------------------
-- MP +12%(Cap: 90@750 Base MP)
-- Intelligence +6
-- MP Recovered While Healing +2
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5158)
end

function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_MPP, 12)
    target:addMod(tpz.mod.FOOD_MP_CAP, 90)
    target:addMod(tpz.mod.INT, 6)
    target:addMod(tpz.mod.MPHEAL, 2)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_MPP, 12)
    target:delMod(tpz.mod.FOOD_MP_CAP, 90)
    target:delMod(tpz.mod.INT, 6)
    target:delMod(tpz.mod.MPHEAL, 2)
end
