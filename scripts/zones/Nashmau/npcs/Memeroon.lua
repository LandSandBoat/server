-----------------------------------
-- Area: Nashmau
--  NPC: Memeroon
-- Type: Appraiser
-- !pos -26 0 -40 53
-----------------------------------
require("scripts/globals/appraisal")
-----------------------------------

local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.appraisalUtil.appraiseItem(player, npc, trade, 500, 273)
end

entity.onTrigger = function(player, npc)
    player:startEvent(272, 500)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.appraisalUtil.appraisalOnEventFinish(player, csid, option, 500, 273, npc)
end

return entity
