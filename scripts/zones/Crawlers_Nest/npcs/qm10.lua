-----------------------------------
-- Area: Crawlers' Nest
--  NPC: qm10 (??? - Exoray Mold Crumbs)
-- Involved in Quest: In Defiant Challenge
-- !pos -83.391 -8.222 79.065 197
-----------------------------------
local func = require("scripts/zones/Crawlers_Nest/globals")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    func.moldQmOnTrigger(player, xi.ki.EXORAY_MOLD_CRUMB1)
end

entity.onEventUpdate = function(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
