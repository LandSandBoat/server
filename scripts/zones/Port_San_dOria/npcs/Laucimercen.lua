-----------------------------------
-- Area: Port San d'Oria
--  NPC: Laucimercen
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("thePickpocket") == 1 then
        player:showText(npc, ID.text.PICKPOCKET_LAUCIMERCEN)
    else
        player:startEvent(563)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
