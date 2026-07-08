-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Maturiri
-- Type: Item Deliverer
-- !pos -77.366 -20 -71.128 26
-----------------------------------
local ID = zones[xi.zone.TAVNAZIAN_SAFEHOLD]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(xi.mission.log_id.COP) >= xi.mission.id.cop.DARKNESS_NAMED then
        player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
        player:openSendBox()
    else
        player:showText(npc, ID.text.KEEP_INVENTORY)
    end
end

return entity
