-----------------------------------
-- ID: 15958
-- Combat Caster's Quiver
-- When used, you will obtain one Combat Caster's Arrow
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    target:addItem(xi.item.COMBAT_CASTERS_ARROW)
end

return itemObject
