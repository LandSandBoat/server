-----------------------------------
-- ID: 4446
-- Item: pumpkin_pie
-- Food Effect: 30Min, All Races
-----------------------------------
-- Magic 40
-- Agility -1
-- Intelligence 3
-- Charisma -2
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 4446)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, 40)
    target:addMod(xi.mod.AGI, -1)
    target:addMod(xi.mod.INT, 3)
    target:addMod(xi.mod.CHR, -2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, 40)
    target:delMod(xi.mod.AGI, -1)
    target:delMod(xi.mod.INT, 3)
    target:delMod(xi.mod.CHR, -2)
end

return itemObject
