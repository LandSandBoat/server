-----------------------------------
-- ID: 4421
-- Item: melon_pie
-- Food Effect: 30Min, All Races
-----------------------------------
-- Magic 25
-- Agility -1
-- Intelligence 4
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:hasStatusEffect(xi.effect.FOOD) then
        result = xi.msg.basic.IS_FULL
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 4421)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, 25)
    target:addMod(xi.mod.AGI, -1)
    target:addMod(xi.mod.INT, 4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, 25)
    target:delMod(xi.mod.AGI, -1)
    target:delMod(xi.mod.INT, 4)
end

return itemObject
