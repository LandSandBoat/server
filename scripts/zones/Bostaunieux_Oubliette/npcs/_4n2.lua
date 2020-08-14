-----------------------------------
-- Area: Bostaunieux Obliette
--  NPC: _4n2 (Sewer Lid)
-- !pos -19.000 -17.899 20.000 167
-----------------------------------
local ID = require("scripts/zones/Bostaunieux_Oubliette/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.SEEMS_LOCKED)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option, npc)
end
