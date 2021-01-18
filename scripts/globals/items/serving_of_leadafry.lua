-----------------------------------
-- ID: 5161
-- Item: serving_of_leadafry
-- Food Effect: 240Min, All Races
-----------------------------------
-- Agility 5
-- Vitality 2
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
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 14400, 5161)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.AGI, 5)
    target:addMod(tpz.mod.VIT, 2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.AGI, 5)
    target:delMod(tpz.mod.VIT, 2)
end

return item_object
