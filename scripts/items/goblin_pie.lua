-----------------------------------
-- ID: 4539
-- Item: goblin_pie
-- Food Effect: 30Min, All Races
-----------------------------------
-- Health 12
-- Magic 12
-- Dexterity -1
-- Agility 3
-- Vitality -1
-- Charisma -5
-- Defense % 9 (cap 100)
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HP, 12)
    effect:addMod(xi.mod.FOOD_MP, 12)
    effect:addMod(xi.mod.DEX, -1)
    effect:addMod(xi.mod.AGI, 3)
    effect:addMod(xi.mod.VIT, -1)
    effect:addMod(xi.mod.CHR, -5)
    effect:addMod(xi.mod.FOOD_DEFP, 9)
    effect:addMod(xi.mod.FOOD_DEF_CAP, 100)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
