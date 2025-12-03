-----------------------------------
-- ID: 5164
-- Item: jar_of_ground_wasabi
-- Food Effect: 5Min, All Races
-----------------------------------
-- Strength -1
-- Dexterity -1
-- Agility -1
-- Vitality -1
-- Intelligence -1
-- Mind -1
-- Charisma -1
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 300, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.STR, -1)
    effect:addMod(xi.mod.DEX, -1)
    effect:addMod(xi.mod.AGI, -1)
    effect:addMod(xi.mod.VIT, -1)
    effect:addMod(xi.mod.INT, -1)
    effect:addMod(xi.mod.MND, -1)
    effect:addMod(xi.mod.CHR, -1)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
