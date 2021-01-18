-----------------------------------
-- ID: 4520
-- Item: coin_cookie
-- Food Effect: 5Min, All Races
-----------------------------------
-- Magic Regen While Healing 6
-- Vermin Killer 12
-- Poison Resist 12
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 300, 4520)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.MPHEAL, 6)
    target:addMod(tpz.mod.VERMIN_KILLER, 12)
    target:addMod(tpz.mod.POISONRES, 12)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.MPHEAL, 6)
    target:delMod(tpz.mod.VERMIN_KILLER, 12)
    target:delMod(tpz.mod.POISONRES, 12)
end

return item_object
