-----------------------------------
-- ID: 5210
-- Item: Bowl of Adamantoise Soup
-- Food Effect: 180Min, All Races
-----------------------------------
-- Strength -7
-- Dexterity -7
-- Agility -7
-- Vitality -7
-- Intelligence -7
-- Mind -7
-- Charisma -7
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 5210)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.STR, -7)
    target:addMod(xi.mod.DEX, -7)
    target:addMod(xi.mod.AGI, -7)
    target:addMod(xi.mod.VIT, -7)
    target:addMod(xi.mod.INT, -7)
    target:addMod(xi.mod.MND, -7)
    target:addMod(xi.mod.CHR, -7)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.STR, -7)
    target:delMod(xi.mod.DEX, -7)
    target:delMod(xi.mod.AGI, -7)
    target:delMod(xi.mod.VIT, -7)
    target:delMod(xi.mod.INT, -7)
    target:delMod(xi.mod.MND, -7)
    target:delMod(xi.mod.CHR, -7)
end

return item_object
