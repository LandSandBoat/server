-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Rodaillece
-- !pos -246.943 7.000 46.836 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCharVar("thePickpocket") == 1 and not player:getMaskBit(player:getCharVar("thePickpocketSkipNPC"), 3) then
        player:showText(npc, ID.text.PICKPOCKET_RODAILLECE)
        player:setMaskBit(player:getCharVar("thePickpocketSkipNPC"), "thePickpocketSkipNPC", 3, true)
    else
        player:showText(npc, ID.text.RODAILLECE_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
