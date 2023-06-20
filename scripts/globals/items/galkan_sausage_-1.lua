-----------------------------------
-- ID: 5862
-- Item: galkan_sausage_-1
-- Food Effect: 30Min, All Races
-----------------------------------
-- Strength -3
-- Dexterity -3
-- Vitality -3
-- Agility -3
-- Mind -3
-- Intelligence -3
-- Charisma -3
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 5862)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, -3)
    target:addMod(xi.mod.DEX, -3)
    target:addMod(xi.mod.VIT, -3)
    target:addMod(xi.mod.AGI, -3)
    target:addMod(xi.mod.MND, -3)
    target:addMod(xi.mod.INT, -3)
    target:addMod(xi.mod.CHR, -3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, -3)
    target:delMod(xi.mod.DEX, -3)
    target:delMod(xi.mod.VIT, -3)
    target:delMod(xi.mod.AGI, -3)
    target:delMod(xi.mod.MND, -3)
    target:delMod(xi.mod.INT, -3)
    target:delMod(xi.mod.CHR, -3)
end

return itemObject
