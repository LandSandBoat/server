-----------------------------------------
-- ID: 6565
-- Item: Persikos Snow Cone
-- Food Effect: 5 minutes, all Races
-----------------------------------------
-- MP +35% (Max. 50 @ 143 Base MP)
-- INT +3
-- [Element: Air]+5
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 6565)
end
function onEffectGain(target, effect)
    target:addMod(tpz.mod.FOOD_MPP, 35)
    target:addMod(tpz.mod.FOOD_MP_CAP, 50)
    target:addMod(tpz.mod.INT, 3)
    target:addMod(tpz.mod.WINDDEF, 5)
end

function onEffectLose(target, effect)
    target:delMod(tpz.mod.FOOD_MPP, 35)
    target:delMod(tpz.mod.FOOD_MP_CAP, 50)
    target:delMod(tpz.mod.INT, 3)
    target:delMod(tpz.mod.WINDDEF, 5)
end
