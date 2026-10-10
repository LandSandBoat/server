-----------------------------------
-- ID: 14654
-- Item: Poisona Ring
-- Item Effect: Enchantment: Poisona
-- https://wiki.ffo.jp/html/8859.html
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if
        target:hasEquipped(xi.item.POISONA_RING) and
        target:hasStatusEffect(xi.effect.POISON)
    then
        target:delStatusEffect(xi.effect.POISON)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
