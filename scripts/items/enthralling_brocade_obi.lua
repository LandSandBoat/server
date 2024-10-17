-----------------------------------
-- ID: 15862
-- Item: enthralling_brocade_obi
-- Item Effect: CHR+10
-- Duration: 3 Minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.ENTHRALLING_BROCADE_OBI) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.ENTHRALLING_BROCADE_OBI)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.ENTHRALLING_BROCADE_OBI) then
        target:addStatusEffect(xi.effect.CHR_BOOST, 10, 0, 180, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.ENTHRALLING_BROCADE_OBI)
    end
end

return itemObject
