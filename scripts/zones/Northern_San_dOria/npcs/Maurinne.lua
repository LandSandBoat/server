-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Maurinne
-- !pos -127.185 0.000 179.193 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("thePickpocket") == 1 then
        player:showText(npc, ID.text.PICKPOCKET_MAURINNE)
        player:showText(npc, ID.text.PICKPOCKET_MAURINNE + 1)
    else
        player:showText(npc, ID.text.MAURINNE_DIALOG)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
