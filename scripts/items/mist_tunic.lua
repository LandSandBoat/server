-----------------------------------
-- ID: 14423
-- Item: Mist Tunic
-- Item Effect: Evasion Boost
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.item.MIST_TUNIC) then
        if not target:hasStatusEffect(xi.effect.EVASION_BOOST) then
            target:addStatusEffect(xi.effect.EVASION_BOOST, 20, 0, 180, 0, 0, 0, xi.effectSourceType.EQUIPPED_ITEM, xi.item.MIST_TUNIC)
        else
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        end
    end
end

return itemObject
