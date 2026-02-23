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

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.NARUKO_EARRING) then
        target:addStatusEffect(xi.effect.ENMITY_BOOST, { power = 10, duration = 180, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.NARUKO_EARRING })
    end
end

return itemObject
