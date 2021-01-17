-----------------------------------------
-- ID: 5637
-- Item: pogaca
-- Food Effect: 5Min, All Races
-----------------------------------------
-- Lizard Killer +10
-- Resist Paralyze +10
-- HP Recovered While Healing 4
-- MP Recovered While Healing 4
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 5637)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.LIZARD_KILLER, 10)
    target:addMod(tpz.mod.PARALYZERES, 10)
    target:addMod(tpz.mod.HPHEAL, 4)
    target:addMod(tpz.mod.MPHEAL, 4)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.LIZARD_KILLER, 10)
    target:delMod(tpz.mod.PARALYZERES, 10)
    target:delMod(tpz.mod.HPHEAL, 4)
    target:delMod(tpz.mod.MPHEAL, 4)
end

return item_object
