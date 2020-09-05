-----------------------------------
-- Area: Al Zahbi
--  NPC: Taten-Bilten
--  Guild Merchant NPC: Clothcraft Guild
-- !pos 71.598 -6.000 -56.930 48
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/shop")
local ID = require("scripts/zones/Al_Zahbi/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:sendGuild(60430, 6, 21, 0) then
        player:showText(npc, ID.text.TATEN_BILTEN_SHOP_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
