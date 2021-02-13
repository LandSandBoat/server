-----------------------------------
-- Area: Port San d'Oria
--  NPC: Maunadolace
-- Type: Standard NPC
-- !pos -22.800 -9.3 -148.645 232
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("thePickpocket") == 1 then
        player:showText(npc, ID.text.PICKPOCKET_MAUNADOLACE)
    else
        player:startEvent(713)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
