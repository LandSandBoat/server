-----------------------------------
-- ID: 5641
-- Item: M&P Dumpling
-- Food Effect: 3Min, All Races
-----------------------------------
-- Intelligence 5
-- Agility -5
-- MP 30
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 180, 5641)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, 30)
    target:addMod(xi.mod.INT, 5)
    target:addMod(xi.mod.AGI, -5)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, 30)
    target:delMod(xi.mod.INT, 5)
    target:delMod(xi.mod.AGI, -5)
end

return item_object
