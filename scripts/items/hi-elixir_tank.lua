-----------------------------------
-- ID: 26271
-- Hi-Elixir Tank
-- When used, you will obtain one hi-elixir
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.HI_ELIXIR, 1 } })
end

return itemObject
