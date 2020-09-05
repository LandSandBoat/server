-----------------------------------
-- Area: Carpenters' Landing
--  NPC: Beugungel
-- Type: Guild Merchant NPC (Woodworking Guild)
-- !pos -333.729, -5.512, 475.647 2
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/shop")
local ID = require("scripts/zones/Carpenters_Landing/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:sendGuild(534, 5, 22, 0)) then
        player:showText(npc, ID.text.BEUGUNGEL_SHOP_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
