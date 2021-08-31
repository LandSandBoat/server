-----------------------------------
-- ID: 4281
-- Item: red_hot_cracker
-- Food Effect: 3Min, All Races
-----------------------------------
-- HP Recovered While Healing 9
-- Beast Killer 12
-- Resist Sleep 12
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 180, 4281)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HPHEAL, 9)
    target:addMod(xi.mod.BEAST_KILLER, 12)
    target:addMod(xi.mod.SLEEPRES, 12)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HPHEAL, 9)
    target:delMod(xi.mod.BEAST_KILLER, 12)
    target:delMod(xi.mod.SLEEPRES, 12)
end

return item_object
