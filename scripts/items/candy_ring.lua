-----------------------------------
-- ID: 5621
-- Item: Candy Ring
-- Food Effect: 4 Hrs, All Races
-----------------------------------
-- Dexterity 4
-- Agility 4
-- Charisma 4
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, { duration = 14400, origin = user, sourceType = xi.effectSourceType.FOOD, sourceTypeParam = item:getID() })
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.DEX, 4)
    effect:addMod(xi.mod.AGI, 4)
    effect:addMod(xi.mod.CHR, 4)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
