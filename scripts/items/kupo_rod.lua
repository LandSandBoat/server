-----------------------------------
-- ID: 21074
-- Item: Kupo Rod
-- Enchantment: Moogle Blessing (removes Weakness)
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if not target:hasStatusEffect(xi.effect.WEAKNESS) then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    else
        return 0
    end
end

itemObject.onItemUse = function(target)
    if target:hasStatusEffect(xi.effect.WEAKNESS) then
        target:delStatusEffect(xi.effect.WEAKNESS)
    end
end

return itemObject
