-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: ???
-- NPC for Dynamis Divergence Quest
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
