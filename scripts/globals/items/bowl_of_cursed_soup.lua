-----------------------------------
-- ID: 4235
-- Item: Bowl of Cursed Soup
-- Food Effect: 240Min, All Races
-----------------------------------
-- Strength -7
-- Dexterity -7
-- Agility -7
-- Vitality -7
-- Intelligence -7
-- Mind -7
-- Charisma -7
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 4235)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, -7)
    target:addMod(xi.mod.DEX, -7)
    target:addMod(xi.mod.AGI, -7)
    target:addMod(xi.mod.VIT, -7)
    target:addMod(xi.mod.INT, -7)
    target:addMod(xi.mod.MND, -7)
    target:addMod(xi.mod.CHR, -7)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, -7)
    target:delMod(xi.mod.DEX, -7)
    target:delMod(xi.mod.AGI, -7)
    target:delMod(xi.mod.VIT, -7)
    target:delMod(xi.mod.INT, -7)
    target:delMod(xi.mod.MND, -7)
    target:delMod(xi.mod.CHR, -7)
end

return itemObject
