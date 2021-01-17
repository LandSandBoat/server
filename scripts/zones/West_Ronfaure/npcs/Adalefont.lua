-----------------------------------
-- Area: West Ronfaure
--  NPC: Adalefont
-- !pos -176.000 -61.999 377.460 100
-----------------------------------
local ID = require("scripts/zones/West_Ronfaure/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("thePickpocket") == 1 then
        player:showText(npc, ID.text.PICKPOCKET_ADALEFONT)
    else
        player:showText(npc, ID.text.ADALEFONT_DIALOG)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
