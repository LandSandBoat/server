-----------------------------------
-- Area: West Ronfaure
--  NPC: Gachemage
-- Type: Gate Guard
-- !pos -176.000 -61.999 382.425 100
-----------------------------------
local ID = require("scripts/zones/West_Ronfaure/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("thePickpocket") == 1 then
        player:showText(npc, ID.text.PICKPOCKET_GACHEMAGE)
    else
        player:showText(npc, ID.text.GACHEMAGE_DIALOG)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
