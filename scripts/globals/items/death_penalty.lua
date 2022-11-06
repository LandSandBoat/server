-----------------------------------
-- ID: 19007
-- Item: Death Penalty
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/msg")
require("scripts/globals/npc_util")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getFreeSlotsCount() == 0 then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.items.LIVING_BULLET, 99 } }) -- Living Bullet x99
end

return itemObject
