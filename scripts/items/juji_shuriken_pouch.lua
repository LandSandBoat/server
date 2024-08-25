-----------------------------------
-- ID: 6297
-- Item: Juji Shr. Pouch
-- When used, you will obtain one stack of Juji Shurikens
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.JUJI_SHURIKEN, 99 } })
end

return itemObject
