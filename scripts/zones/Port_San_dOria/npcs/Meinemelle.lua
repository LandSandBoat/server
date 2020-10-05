-----------------------------------
-- Area: Port San d'Oria
--  NPC: Meinemelle
-- !pos -8.289 -9.3 -146.093 232
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
require("scripts/globals/utils")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCharVar("thePickpocket") == 1 and not utils.mask.getBit(player:getCharVar("thePickpocketSkipNPC"), 0) then
        player:showText(npc, ID.text.PICKPOCKET_MEINEMELLE)
        player:setCharVar("thePickpocketSkipNPC", utils.mask.setBit(player:getCharVar("thePickpocketSkipNPC"), 0, true))
    else
        player:showText(npc, ID.text.ITEM_DELIVERY_DIALOG)
        player:openSendBox()
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
