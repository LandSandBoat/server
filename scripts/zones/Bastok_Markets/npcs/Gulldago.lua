-----------------------------------
-- Area: Bastok Markets
--  NPC: Gulldago
-- Type: Tutorial NPC
-- !pos -364.121 -11.034 -167.456 235
-----------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/npc_util")
require("scripts/quests/tutorial")
-----------------------------------


function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.tutorial.onTrigger(player, npc, 518, 1)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.tutorial.onEventFinish(player, csid, option, 518, 1)
end
