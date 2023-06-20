-----------------------------------
-- ID: 4279
-- Item: tavnazian_salad
-- Food Effect: 180Min, All Races
-----------------------------------
-- Health 20
-- Magic 20
-- Dexterity 4
-- Agility 4
-- Vitality 6
-- Charisma 4
-- Defense % 25
-- Defense Cap 150
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 4279)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 20)
    target:addMod(xi.mod.MP, 20)
    target:addMod(xi.mod.DEX, 4)
    target:addMod(xi.mod.AGI, 4)
    target:addMod(xi.mod.VIT, 6)
    target:addMod(xi.mod.CHR, 4)
    target:addMod(xi.mod.FOOD_DEFP, 25)
    target:addMod(xi.mod.FOOD_DEF_CAP, 150)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 20)
    target:delMod(xi.mod.MP, 20)
    target:delMod(xi.mod.DEX, 4)
    target:delMod(xi.mod.AGI, 4)
    target:delMod(xi.mod.VIT, 6)
    target:delMod(xi.mod.CHR, 4)
    target:delMod(xi.mod.FOOD_DEFP, 25)
    target:delMod(xi.mod.FOOD_DEF_CAP, 150)
end

return itemObject
