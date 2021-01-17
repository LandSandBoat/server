-----------------------------------------
-- ID: 4468
-- Item: Bunch of Pamamas
-- Food Effect: 30Min, All Races
-----------------------------------------
-- Strength -3
-- Intelligence 1
-- Additional Effect with Opo-Opo Crown
-- HP 50
-- MP 50
-- CHR 14
-- Additional Effect with Kinkobo or
-- Primate Staff
-- DELAY -90
-- ACC 10
-- Additional Effect with Primate Staff +1
-- DELAY -80
-- ACC 12
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 1800, 4468)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.STR, -3)
    target:addMod(tpz.mod.INT, 1)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.STR, -3)
    target:delMod(tpz.mod.INT, 1)
end

return item_object
