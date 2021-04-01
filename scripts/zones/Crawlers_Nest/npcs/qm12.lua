-----------------------------------
-- Area: Crawlers' Nest
--  NPC: qm12 (??? - Exoray Mold Crumbs)
-- Involved in Quest: In Defiant Challenge
-- !pos 99.326 -0.126 -188.869 197
-----------------------------------
local func = require("scripts/zones/Crawlers_Nest/globals")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    func.moldQmOnTrigger(player, xi.ki.EXORAY_MOLD_CRUMB3)
end

entity.onEventUpdate = function(player, csid, option)
    -- printf("CSID2: %u", csid)
    -- printf("RESULT2: %u", option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
