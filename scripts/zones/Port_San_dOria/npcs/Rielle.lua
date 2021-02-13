-----------------------------------
-- Area: Port San d'Oria
--  NPC: Rielle
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("thePickpocket") == 1 then
        player:showText(npc, ID.text.PICKPOCKET_RIELLE)
    else
        player:startEvent(564)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
