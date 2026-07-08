-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Suzel
-- Type: Item Deliverer
-- !pos -72.701 -20.25 -64.058 26
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
        player:showText(npc, ID.text.LOTS_OF_STORAGE)
    end
end

return entity
