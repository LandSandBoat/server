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
    if target:hasStatusEffect(tpz.effect.FOOD) or target:hasStatusEffect(tpz.effect.FIELD_SUPPORT_FOOD) then
        result = tpz.msg.basic.IS_FULL
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.FOOD, 0, 0, 10800, 5210)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.STR, -7)
    target:addMod(tpz.mod.DEX, -7)
    target:addMod(tpz.mod.AGI, -7)
    target:addMod(tpz.mod.VIT, -7)
    target:addMod(tpz.mod.INT, -7)
    target:addMod(tpz.mod.MND, -7)
    target:addMod(tpz.mod.CHR, -7)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.STR, -7)
    target:delMod(tpz.mod.DEX, -7)
    target:delMod(tpz.mod.AGI, -7)
    target:delMod(tpz.mod.VIT, -7)
    target:delMod(tpz.mod.INT, -7)
    target:delMod(tpz.mod.MND, -7)
    target:delMod(tpz.mod.CHR, -7)
end

return item_object
