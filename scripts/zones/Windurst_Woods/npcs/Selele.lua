-----------------------------------
-- Area: Windurst Woods
--  NPC: Selele
-- Type: Tutorial NPC
-- !pos 106.9 -5 -31.5 241
-----------------------------------
local ID = require("scripts/zones/Windurst_Woods/IDs")
require("scripts/globals/status")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/npc_util")
require("scripts/quests/tutorial")
-----------------------------------


function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.tutorial.onTrigger(player, npc, 813, 2)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.tutorial.onEventFinish(player, csid, option, 813, 2)
end
