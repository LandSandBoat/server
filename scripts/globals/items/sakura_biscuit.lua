-----------------------------------
-- ID: 6010
-- Item: Sakura Biscuit
-- Food Effect: 30Min, All Races
-----------------------------------
-- Intelligence 3
-- Charisma 2
-- Evasion +2
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 6010)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.INT, 3)
    target:addMod(xi.mod.CHR, 2)
    target:addMod(xi.mod.EVA, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.INT, 3)
    target:delMod(xi.mod.CHR, 2)
    target:delMod(xi.mod.EVA, 2)
end

return itemObject
