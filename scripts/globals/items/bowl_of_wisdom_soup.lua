-----------------------------------
-- ID: 4592
-- Item: bowl_of_wisdom_soup
-- Food Effect: 4Hrs, All Races
-----------------------------------
-- HP 3
-- MP 3
-- Strength 1
-- Dexterity 1
-- Agility 1
-- Vitality 1
-- Intelligence 1
-- Mind 1
-- Charisma 1
-- HP Recovered While Healing 3
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 4592)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 3)
    target:addMod(xi.mod.MP, 3)
    target:addMod(xi.mod.STR, 1)
    target:addMod(xi.mod.DEX, 1)
    target:addMod(xi.mod.AGI, 1)
    target:addMod(xi.mod.VIT, 1)
    target:addMod(xi.mod.INT, 1)
    target:addMod(xi.mod.MND, 1)
    target:addMod(xi.mod.CHR, 1)
    target:addMod(xi.mod.HPHEAL, 3)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 3)
    target:delMod(xi.mod.MP, 3)
    target:delMod(xi.mod.STR, 1)
    target:delMod(xi.mod.DEX, 1)
    target:delMod(xi.mod.AGI, 1)
    target:delMod(xi.mod.VIT, 1)
    target:delMod(xi.mod.INT, 1)
    target:delMod(xi.mod.MND, 1)
    target:delMod(xi.mod.CHR, 1)
    target:delMod(xi.mod.HPHEAL, 3)
end

return itemObject
