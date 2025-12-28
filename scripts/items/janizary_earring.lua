-----------------------------------
-- ID: 14785
-- Item: Janizary Earring
-- Item Effect: Defence +32
-- Duration 3 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.DEFENSE_BOOST, xi.effectSourceType.EQUIPPED_ITEM, xi.item.JANIZARY_EARRING) ~= nil then
        target:delStatusEffect(xi.effect.DEFENSE_BOOST, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.JANIZARY_EARRING)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.JANIZARY_EARRING) then
        target:addStatusEffect(xi.effect.DEFENSE_BOOST, 0, 0, 180, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.JANIZARY_EARRING)
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.DEF, 32)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
