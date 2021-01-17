-----------------------------------
-- Area: Bastok Mines
--  NPC: Survival Guide
-----------------------------------
require("scripts/globals/survival_guide")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, targetNpc)
    tpz.survivalGuide.onTrigger(player)
end

entity.onEventUpdate = function(player, csid, option)
    tpz.survivalGuide.onEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, targetNpc)
    tpz.survivalGuide.onEventFinish(player, csid, option)
end

return entity
