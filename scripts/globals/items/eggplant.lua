-----------------------------------
-- ID: 4388
-- Item: eggplant
-- Food Effect: 5Min, All Races
-----------------------------------
-- Agility 3
-- Vitality -5
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 4388)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.AGI, 3)
    target:addMod(xi.mod.VIT, -5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.AGI, 3)
    target:delMod(xi.mod.VIT, -5)
end

return itemObject
