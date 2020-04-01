-----------------------------------
-- Area: Qufim Island
--  NPC: Giant Footprint
-- Involved in quest: Regaining Trust
-- !pos 501 -11 354 126
-----------------------------------
local ID = require("scripts/zones/Qufim_Island/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.GIGANTIC_FOOTPRINT)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
