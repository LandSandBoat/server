-----------------------------------
-- Area: Crawlers' Nest
--  NPC: qm11 (??? - Exoray Mold Crumbs)
-- Involved in Quest: In Defiant Challenge
-- !pos 98.081 -38.75 -181.198 197
-----------------------------------
local func = require("scripts/zones/Crawlers_Nest/globals")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    func.moldQmOnTrigger(player, tpz.ki.EXORAY_MOLD_CRUMB2)
end

entity.onEventUpdate = function(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
