-----------------------------------
-- ID: 5940
-- Item: Trail Cookie
-- Food Effect: 5Min, All Races
-----------------------------------
-- MP Healing 5
-- Aquan Killer 12
-- Sleep Resist 10
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 5940)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MPHEAL, 5)
    target:addMod(xi.mod.AQUAN_KILLER, 12)
    target:addMod(xi.mod.SLEEPRES, 10)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MPHEAL, 5)
    target:delMod(xi.mod.AQUAN_KILLER, 12)
    target:delMod(xi.mod.SLEEPRES, 10)
end

return item_object
