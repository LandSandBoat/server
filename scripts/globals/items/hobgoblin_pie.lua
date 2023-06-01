-----------------------------------
-- ID: 4325
-- Item: hobgoblin_pie
-- Food Effect: 60Min, All Races
-----------------------------------
-- Health 15
-- Magic 15
-- Agility 4
-- Charisma -7
-- Health Regen While Healing 2
-- Defense % 12 (cap 60)
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 4325)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 15)
    target:addMod(xi.mod.MP, 15)
    target:addMod(xi.mod.AGI, 4)
    target:addMod(xi.mod.CHR, -7)
    target:addMod(xi.mod.HPHEAL, 2)
    target:addMod(xi.mod.FOOD_DEFP, 12)
    target:addMod(xi.mod.FOOD_DEF_CAP, 60)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 15)
    target:delMod(xi.mod.MP, 15)
    target:delMod(xi.mod.AGI, 4)
    target:delMod(xi.mod.CHR, -7)
    target:delMod(xi.mod.HPHEAL, 2)
    target:delMod(xi.mod.FOOD_DEFP, 12)
    target:delMod(xi.mod.FOOD_DEF_CAP, 60)
end

return itemObject
