-----------------------------------
-- ID: 22143
-- Item: Fomalhaut
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getFreeSlotsCount() == 0 then
        return xi.msg.basic.ITEM_UNABLE_TO_USE
    end

    return 0
end

itemObject.onItemUse = function(target)
    npcUtil.giveItem(target, { { xi.item.CHRONO_BULLET, 99 } }) -- Chrono Bullet x99
end

return itemObject
