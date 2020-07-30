-----------------------------------------
-- ID: 5718
-- Item: Cream Puff
-- Food Effect: 30 mintutes, All Races
-----------------------------------------
-- Intelligence +7
-- HP -10
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
   target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 5718)
end

function onEffectGain(target, effect)
   target:addMod(tpz.mod.INT, 7)
   target:addMod(tpz.mod.HP, -10)
end

function onEffectLose(target, effect)
   target:delMod(tpz.mod.INT, 7)
   target:delMod(tpz.mod.HP, -10)
end
