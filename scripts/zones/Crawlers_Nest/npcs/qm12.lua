-----------------------------------
-- Area: Crawlers' Nest
--  NPC: qm12 (??? - Exoray Mold Crumbs)
-- Involved in Quest: In Defiant Challenge
-- !pos 99.326 -0.126 -188.869 197
-----------------------------------
local func = require("scripts/zones/Crawlers_Nest/globals")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    func.moldQmOnTrigger(player, tpz.ki.EXORAY_MOLD_CRUMB3)
end

function onEventUpdate(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

function onEventFinish(player, csid, option)
end
