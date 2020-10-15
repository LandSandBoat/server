-----------------------------------
-- Area: Crawlers' Nest
--  NPC: qm10 (??? - Exoray Mold Crumbs)
-- Involved in Quest: In Defiant Challenge
-- !pos -83.391 -8.222 79.065 197
-----------------------------------
local func = require("scripts/zones/Crawlers_Nest/globals")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    func.moldQmOnTrigger(player, tpz.ki.EXORAY_MOLD_CRUMB1)
end

function onEventUpdate(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

function onEventFinish(player, csid, option)
end
