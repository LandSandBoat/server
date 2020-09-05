-----------------------------------
-- Area: Port San d'Oria
--  NPC: Comittie
-- !pos -6.570 -9.8 -147.952 232
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCharVar("thePickpocket") == 1 and not player:getMaskBit(player:getCharVar("thePickpocketSkipNPC"), 1) then
        player:showText(npc, ID.text.PICKPOCKET_COMITTIE)
        player:setMaskBit(player:getCharVar("thePickpocketSkipNPC"), "thePickpocketSkipNPC", 1, true)
    else
        player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
        player:openSendBox()
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
