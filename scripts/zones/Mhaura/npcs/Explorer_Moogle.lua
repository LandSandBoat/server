-----------------------------------
-- Area: Mhaura
--  NPC: Explorer Moogle
-----------------------------------
require("scripts/globals/teleports")
-----------------------------------

local eventId = 334

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.teleport.explorerMoogleOnTrigger(player, eventId)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.teleport.explorerMoogleOnEventFinish(player, csid, option, eventId)
end
