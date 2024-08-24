-----------------------------------
-- ID: 15958
-- Combat Caster's Quiver
-- When used, you will obtain one Combat Caster's Arrow
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.COMBAT_CASTERS_ARROW, 1 } })
end

return itemObject
