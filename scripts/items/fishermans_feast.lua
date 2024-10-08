-----------------------------------
-- ID: 6381
-- Item: Fisherman's_Feast
-- Food Effect: 30Min, All Races
-----------------------------------
--  Fishing skill gain rate+5%
--  https://ffxiclopedia.fandom.com/wiki/Fisherman's_Feast
--  https://www.bg-wiki.com/ffxi/Fisherman%27s_Feast
-----------------------------------
---@type TItemFood
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.foodOnItemCheck(target, xi.foodType.BASIC)
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.FOOD, 0, 0, 1800, 6381)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.FISHING_SKILL_GAIN, 5)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.FISHING_SKILL_GAIN, 5)
end

return itemObject
