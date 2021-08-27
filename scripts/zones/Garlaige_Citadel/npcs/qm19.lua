-----------------------------------
-- Area: Garlaige Citadel
--  NPC: qm19 (??? - Bomb Coal Fragments)
-- Involved in Quest: In Defiant Challenge
-- !pos -50.175 6.264 251.669 200
-----------------------------------
local func = require("scripts/zones/Garlaige_Citadel/globals")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    func.coalQmOnTrigger(player, xi.ki.BOMB_COAL_FRAGMENT2)
end

entity.onEventUpdate = function(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
