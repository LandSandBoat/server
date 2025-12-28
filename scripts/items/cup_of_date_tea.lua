-----------------------------------
-- ID: 5926
-- Item: Cup of Date Tea
-- Food Effect: 3 Hrs, All Races
-----------------------------------
-- HP 20
-- MP 30
-- Vitality -1
-- Charisma 5
-- Intelligence 3
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 10800, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.FOOD_HP, 20)
    effect:addMod(xi.mod.FOOD_MP, 30)
    effect:addMod(xi.mod.VIT, -1)
    effect:addMod(xi.mod.CHR, 5)
    effect:addMod(xi.mod.INT, 3)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
