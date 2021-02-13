-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Pepigort
-- !pos -126.739 11.999 262.757 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("thePickpocket") == 1 then
        player:showText(npc, ID.text.PICKPOCKET_PEPIGORT)
    else
        player:showText(npc, ID.text.PEPIGORT_DIALOG)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
