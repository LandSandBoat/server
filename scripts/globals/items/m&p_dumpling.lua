-----------------------------------
-- ID: 5641
-- Item: M&P Dumpling
-- Food Effect: 3Min, All Races
-----------------------------------
-- Intelligence 5
-- Agility -5
-- MP 30
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 180, 5641)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, 30)
    target:addMod(xi.mod.INT, 5)
    target:addMod(xi.mod.AGI, -5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, 30)
    target:delMod(xi.mod.INT, 5)
    target:delMod(xi.mod.AGI, -5)
end

return itemObject
