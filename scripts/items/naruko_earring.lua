-----------------------------------
-- ID: 14789
-- Item: Naruko Earring
-- Item Effect: Enmity +10
-- Duration: 3 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ENMITY_BOOST, xi.effectSourceType.EQUIPPED_ITEM, xi.item.NARUKO_EARRING) ~= nil then
        target:delStatusEffect(xi.effect.ENMITY_BOOST, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.NARUKO_EARRING)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.NARUKO_EARRING) then
        target:addStatusEffect(xi.effect.ENMITY_BOOST, 10, 0, 180, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.NARUKO_EARRING)
    end
end

return itemObject
