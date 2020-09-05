-----------------------------------
-- Area: Windurst Woods
--  NPC: Shih Tayuun
-- Guild Merchant NPC: Bonecrafting Guild
-- !pos -3.064 -6.25 -131.374 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/shop")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:sendGuild(514, 8, 23, 3) then
        player:showText(npc, ID.text.SHIH_TAYUUN_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
