-----------------------------------
-- ID: 5637
-- Item: pogaca
-- Food Effect: 3Min, All Races
-----------------------------------
-- Lizard Killer +10
-- Resist Paralyze +10
-- HP Recovered While Healing 4
-- MP Recovered While Healing 4
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target, user, item, action)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 180, 0, 0, 0, xi.effectSourceType.FOOD, item:getID(), user:getID())
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.LIZARD_KILLER, 10)
    effect:addMod(xi.mod.PARALYZERES, 10)
    effect:addMod(xi.mod.HPHEAL, 4)
    effect:addMod(xi.mod.MPHEAL, 4)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
