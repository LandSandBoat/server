-----------------------------------
-- Area: Bibiki Bay
--  NPC: Mep Nhapopoluko
-- Type: Guild Merchant NPC (Fishing Guild)
-- !pos 464.350 -6 752.731 4
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/shop")
local ID = require("scripts/zones/Bibiki_Bay/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if (player:sendGuild(519, 1, 18, 5)) then
        player:showText(npc, ID.text.MEP_NHAPOPOLUKO_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
