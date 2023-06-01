-----------------------------------
-- ID: 4522
-- Item: Bowl of Jack-o'-Soup
-- Food Effect: 240Min, All Races
-----------------------------------
-- Health % 2 (cap 120)
-- Agility 3
-- Vitality -1
-- Health Regen While Healing 5
-- Ranged ACC % 8
-- Ranged ACC Cap 25
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 14400, 4522)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 2)
    target:addMod(xi.mod.FOOD_HP_CAP, 120)
    target:addMod(xi.mod.AGI, 3)
    target:addMod(xi.mod.VIT, -1)
    target:addMod(xi.mod.HPHEAL, 5)
    target:addMod(xi.mod.FOOD_RACCP, 8)
    target:addMod(xi.mod.FOOD_RACC_CAP, 25)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 2)
    target:delMod(xi.mod.FOOD_HP_CAP, 120)
    target:delMod(xi.mod.AGI, 3)
    target:delMod(xi.mod.VIT, -1)
    target:delMod(xi.mod.HPHEAL, 5)
    target:delMod(xi.mod.FOOD_RACCP, 8)
    target:delMod(xi.mod.FOOD_RACC_CAP, 25)
end

return itemObject
