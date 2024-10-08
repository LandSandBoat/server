-----------------------------------
-- ID: 5317
-- Toolbag Sai
-- When used, you will obtain one stack of sairui-ran
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.SAIRUI_RAN, 99 } })
end

return itemObject
