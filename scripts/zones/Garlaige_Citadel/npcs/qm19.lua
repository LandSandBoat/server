-----------------------------------
-- Area: Garlaige Citadel
--  NPC: qm19 (??? - Bomb Coal Fragments)
-- Involved in Quest: In Defiant Challenge
-- !pos -50.175 6.264 251.669 200
-----------------------------------
local func = require("scripts/zones/Garlaige_Citadel/globals")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    func.coalQmOnTrigger(player, tpz.ki.BOMB_COAL_FRAGMENT2)
end

function onEventUpdate(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

function onEventFinish(player, csid, option)
end
