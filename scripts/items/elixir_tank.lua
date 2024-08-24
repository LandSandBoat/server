-----------------------------------
-- ID: 16249
-- Elixir Tank
-- When used, you will obtain one Elixir
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return xi.itemUtils.itemBoxOnItemCheck(target)
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.ELIXIR, 1 } })
end

return itemObject
