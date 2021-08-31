-----------------------------------
-- ID: 4394
-- Item: ginger_cookie
-- Food Effect: 3Min, All Races
-----------------------------------
-- Magic Regen While Healing 5
-- Plantoid Killer 10
-- Slow Resist 10
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) or target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD) then
        result = xi.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 180, 4394)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MPHEAL, 5)
    target:addMod(xi.mod.PLANTOID_KILLER, 10)
    target:addMod(xi.mod.SLOWRES, 10)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MPHEAL, 5)
    target:delMod(xi.mod.PLANTOID_KILLER, 10)
    target:delMod(xi.mod.SLOWRES, 10)
end

return item_object
