-----------------------------------
-- Area: Windurst Waters
--  NPC: Voidwatch Purveyor
-- Voidwatch vendor — sells ascent cells and voiddust for conquest points
-- !pos -27.500 -5.396 225.500 238
-----------------------------------
require('scripts/globals/voidwatch')
-----------------------------------
---@type TNpcEntity
local entity = {}

local csids =
{
    SHOP_MENU = 1034,
}

-- Item mapping: index -> item ID
local shopItems =
{
    [1] = xi.item.COBALT_CELL,
    [2] = xi.item.RUBICUND_CELL,
    [3] = xi.item.XANTHOUS_CELL,
    [4] = xi.item.JADE_CELL,
    [5] = xi.item.POUCH_OF_VOIDDUST,
}

local COST_PER_ITEM = 2000

entity.onTrigger = function(player, npc)
    local points = player:getCP()
    player:startEvent(csids.SHOP_MENU, 0, points, COST_PER_ITEM, 0, 0, 0, 0)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if option == 0 or option == 0xFFFFFFFF then
        return
    end

    -- option byte 3 (bits 16-23) encodes item + quantity
    -- low 6 bits = item index, high 2 bits = quantity
    local packed = bit.band(bit.rshift(option, 16), 0xFF)
    local itemIndex = bit.band(packed, 0x3F)
    local quantity = bit.rshift(packed, 6)

    local itemId = shopItems[itemIndex]
    if not itemId or quantity < 1 then
        return
    end

    local totalCost = COST_PER_ITEM * quantity

    if player:getCP() < totalCost then
        return
    end

    if player:addItem(itemId, quantity) then
        player:delCP(totalCost)
        player:messageSpecial(zones[player:getZoneID()].text.ITEM_OBTAINED, itemId)
    end
end

return entity
