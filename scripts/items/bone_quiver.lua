-----------------------------------
-- ID: 4220
-- Item: Bone Quiver
-- When used, you will obtain one stack of Bone Arrows
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.BONE_ARROW, 99 } })
end

return itemObject
