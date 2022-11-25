-----------------------------------
-- ID: 5621
-- Item: Candy Ring
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- Dexterity 4
-- Agility 4
-- Charisma 4
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 5621)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.DEX, 4)
    target:addMod(xi.mod.AGI, 4)
    target:addMod(xi.mod.CHR, 4)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.DEX, 4)
    target:delMod(xi.mod.AGI, 4)
    target:delMod(xi.mod.CHR, 4)
end

return itemObject
