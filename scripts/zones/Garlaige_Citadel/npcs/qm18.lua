-----------------------------------
-- Area: Garlaige Citadel
--  NPC: qm18 (??? - Bomb Coal Fragments)
-- Involved in Quest: In Defiant Challenge
-- !pos -13.425, -1.176, 191.669 200
-----------------------------------
local func = require("scripts/zones/Garlaige_Citadel/globals")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    func.coalQmOnTrigger(player, tpz.ki.BOMB_COAL_FRAGMENT1)
end

function onEventUpdate(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

function onEventFinish(player, csid, option)
end
