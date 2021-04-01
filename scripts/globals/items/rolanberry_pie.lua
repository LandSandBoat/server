-----------------------------------
-- ID: 4414
-- Item: rolanberry_pie
-- Food Effect: 30Min, All Races
-----------------------------------
-- Magic 50
-- Agility -1
-- Intelligence 2
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 4414)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, 50)
    target:addMod(xi.mod.AGI, -1)
    target:addMod(xi.mod.INT, 2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, 50)
    target:delMod(xi.mod.AGI, -1)
    target:delMod(xi.mod.INT, 2)
end

return item_object
