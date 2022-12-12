-----------------------------------
-- ID: 5704
-- Item: anglers_cassoulet
-- Food Effect: 30, All Races
-----------------------------------
-- VIT -1
-- AGI +5
-- Ranged Accuracy +1
-- Regen +1
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if
        target:hasStatusEffect(xi.effect.FOOD) or
        target:hasStatusEffect(xi.effect.FIELD_SUPPORT_FOOD)
    then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5704)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.REGEN, 1)
    target:addMod(xi.mod.VIT, -1)
    target:addMod(xi.mod.AGI, 5)
    target:addMod(xi.mod.RACC, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.REGEN, 1)
    target:delMod(xi.mod.VIT, -1)
    target:delMod(xi.mod.AGI, 5)
    target:delMod(xi.mod.RACC, 5)
end

return itemObject
