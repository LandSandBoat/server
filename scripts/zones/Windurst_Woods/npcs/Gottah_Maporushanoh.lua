-----------------------------------
-- Area: Windurst Woods
--  NPC: Gottah Maporushanoh
-- Working 100%
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local AmazinScorpio = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.THE_AMAZIN_SCORPIO)

    if AmazinScorpio == QUEST_COMPLETED then
        player:startEvent(486)
    elseif AmazinScorpio == QUEST_ACCEPTED then
        player:startEvent(483)
    else
        player:startEvent(420)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
