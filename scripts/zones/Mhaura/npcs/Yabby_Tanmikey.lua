-----------------------------------
-- Area: Mhaura
--  NPC: Yabby Tanmikey
--  Guild Merchant NPC: Goldsmithing Guild
-- !pos -36.459 -16.000 76.840 249
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/shop")
local ID = require("scripts/zones/Mhaura/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:sendGuild(528, 8, 23, 4)) then
        player:showText(npc, ID.text.GOLDSMITHING_GUILD)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
