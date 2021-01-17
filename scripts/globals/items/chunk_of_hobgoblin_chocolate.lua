-----------------------------------------
-- ID: 4324
-- Item: chunk_of_hobgoblin_chocolate
-- Food Effect: 5Min, All Races
-----------------------------------------
-- Health Regen While Healing 7
-- Lizard Killer 12
-- Petrify Resist 12
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 4324)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HPHEAL, 7)
    target:addMod(tpz.mod.LIZARD_KILLER, 12)
    target:addMod(tpz.mod.PETRIFYRES, 12)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HPHEAL, 7)
    target:delMod(tpz.mod.LIZARD_KILLER, 12)
    target:delMod(tpz.mod.PETRIFYRES, 12)
end

return item_object
