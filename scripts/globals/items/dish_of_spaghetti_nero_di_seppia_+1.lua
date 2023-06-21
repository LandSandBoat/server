-----------------------------------
-- ID: 5202
-- Item: Dish of Spaghetti Nero Di Seppia +1
-- Food Effect: 60 Mins, All Races
-----------------------------------
-- HP % 17 (cap 140)
-- Dexterity 3
-- Vitality 2
-- Agility -1
-- Mind -2
-- Charisma -1
-- Double Attack 1
-- Store TP 6
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
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 3600, 5202)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FOOD_HPP, 17)
    target:addMod(xi.mod.FOOD_HP_CAP, 140)
    target:addMod(xi.mod.DEX, 3)
    target:addMod(xi.mod.VIT, 2)
    target:addMod(xi.mod.AGI, -1)
    target:addMod(xi.mod.MND, -2)
    target:addMod(xi.mod.CHR, -1)
    target:addMod(xi.mod.DOUBLE_ATTACK, 1)
    target:addMod(xi.mod.STORETP, 6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FOOD_HPP, 17)
    target:delMod(xi.mod.FOOD_HP_CAP, 140)
    target:delMod(xi.mod.DEX, 3)
    target:delMod(xi.mod.VIT, 2)
    target:delMod(xi.mod.AGI, -1)
    target:delMod(xi.mod.MND, -2)
    target:delMod(xi.mod.CHR, -1)
    target:delMod(xi.mod.DOUBLE_ATTACK, 1)
    target:delMod(xi.mod.STORETP, 6)
end

return itemObject
