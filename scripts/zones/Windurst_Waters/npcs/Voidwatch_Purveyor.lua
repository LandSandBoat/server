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

entity.onTrigger = function(player, npc)
    local points = player:getConquestPoints()
    printf('[VW_Purveyor] onTrigger: conquestPoints=%d', points)
    player:startEvent(csids.SHOP_MENU, 0, points, xi.voidwatch.PURVEYOR_ITEM_COST, 0, 0, 0, 0)
end

entity.onEventUpdate = function(player, csid, option, npc)
    printf('[VW_Purveyor] onEventUpdate: csid=%d option=%d (0x%08X)', csid, option, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    printf('[VW_Purveyor] onEventFinish: csid=%d option=%d (0x%08X)', csid, option, option)

    if option == 0 or option == 0xFFFFFFFF then
        return
    end

    local selection = bit.band(option, 0xFF)
    local quantity = bit.band(bit.rshift(option, 8), 0xFF)
    local param3 = bit.band(bit.rshift(option, 16), 0xFF)
    local param4 = bit.band(bit.rshift(option, 24), 0xFF)
    printf('[VW_Purveyor]   parsed: sel=%d qty=%d p3=%d p4=%d', selection, quantity, param3, param4)
end

return entity
