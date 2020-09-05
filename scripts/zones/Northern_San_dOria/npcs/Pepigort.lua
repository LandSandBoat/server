-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Pepigort
-- !pos -126.739 11.999 262.757 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCharVar("thePickpocket") == 1 then
        player:showText(npc, ID.text.PICKPOCKET_PEPIGORT)
    else
        player:showText(npc, ID.text.PEPIGORT_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
