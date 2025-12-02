-----------------------------------
-- ID: 6687
-- Item: gyudon_+1
-- Food Effect: 30Min, All Races
-----------------------------------
-- Enmity -6
-- Double Attack % 6
-- Weapon Skill Damage % 6
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
    target:addMod(xi.mod.ENMITY, -6)
    target:addMod(xi.mod.DOUBLE_ATTACK, 6)
    target:addMod(xi.mod.ALL_WSDMG_ALL_HITS, 6)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ENMITY, -6)
    target:delMod(xi.mod.DOUBLE_ATTACK, 6)
    target:delMod(xi.mod.ALL_WSDMG_ALL_HITS, 6)
end

return itemObject
