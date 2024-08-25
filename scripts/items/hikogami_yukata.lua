-----------------------------------
-- ID: 11861
-- hikogami_yukata
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.SUPER_SCOOP, 1 } })
end

return itemObject
