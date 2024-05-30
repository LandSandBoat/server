-----------------------------------
-- ID: 11862
-- himegami_yukata
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.SUPER_SCOOP, 1 } })
end

return itemObject
