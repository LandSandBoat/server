-----------------------------------
-- Area: Al Zahbi
--  NPC: Chochoroon
-- Type: Appraiser
-- !pos -42.739 -1 -45.987 48
-----------------------------------
require("scripts/globals/appraisal")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    appraisalUtil.appraiseItem(player, npc, trade, 50, 261)
end

entity.onTrigger = function(player, npc)
    player:startEvent(260, 50)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    appraisalUtil.appraisalOnEventFinish(player, csid, option, 50, 261, npc)
end

return entity
