-----------------------------------------
-- ID: 4542
-- Item: Bowl of Brain Stew
-- Food Effect: 180Min, All Races
-----------------------------------------
-- Dexterity 5
-- Intelligence 5
-- Mind 5
-- Health Regen While Healing 3
-- Magic Regen While Healing 3
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 4542)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.DEX, 5)
    target:addMod(tpz.mod.INT, 5)
    target:addMod(tpz.mod.MND, 5)
    target:addMod(tpz.mod.HPHEAL, 3)
    target:addMod(tpz.mod.MPHEAL, 3)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.DEX, 5)
    target:delMod(tpz.mod.INT, 5)
    target:delMod(tpz.mod.MND, 5)
    target:delMod(tpz.mod.HPHEAL, 3)
    target:delMod(tpz.mod.MPHEAL, 3)
end

return item_object
