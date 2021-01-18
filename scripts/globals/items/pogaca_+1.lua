-----------------------------------
-- ID: 5638
-- Item: pogaca_+1
-- Food Effect: 5Min, All Races
-----------------------------------
-- Lizard Killer +12
-- Resist Paralyze +12
-- HP Recovered While Healing 6
-- MP Recovered While Healing 6
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 360, 5638)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.LIZARD_KILLER, 12)
    target:addMod(tpz.mod.PARALYZERES, 12)
    target:addMod(tpz.mod.HPHEAL, 6)
    target:addMod(tpz.mod.MPHEAL, 6)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.LIZARD_KILLER, 12)
    target:delMod(tpz.mod.PARALYZERES, 12)
    target:delMod(tpz.mod.HPHEAL, 6)
    target:delMod(tpz.mod.MPHEAL, 6)
end

return item_object
