-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Drahbah
-- Type: Appraiser
-- !pos -86 0 83 50
-----------------------------------
require("scripts/globals/appraisal")
-----------------------------------

local entity = {}

entity.onTrade = function(player, npc, trade)
    appraisalUtil.appraiseItem(player, npc, trade, 500, 679)
end

entity.onTrigger = function(player, npc)
    player:startEvent(678, 500)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    appraisalUtil.appraisalOnEventFinish(player, csid, option, 500, 679, npc)
end

return entity
