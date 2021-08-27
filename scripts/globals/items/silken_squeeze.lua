-----------------------------------
-- ID: 5630
-- Item: Silken Squeeze
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- TODO: Group Effect
-- HP Recovered while healing +4
-- MP Recovered while healing +5
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5630)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HPHEAL, 4)
    target:addMod(xi.mod.MPHEAL, 5)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HPHEAL, 4)
    target:delMod(xi.mod.MPHEAL, 5)
end

return item_object
