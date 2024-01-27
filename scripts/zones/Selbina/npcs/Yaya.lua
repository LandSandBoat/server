-----------------------------------
-- Area: Selbina
--  NPC: Yaya
-- Starts Quest: Under the sea
-- !pos -19 -2 -16 248
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getFameLevel(xi.quest.fame_area.SELBINA_RABAO) >= 2 and
        player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.UNDER_THE_SEA) == QUEST_AVAILABLE
    then
        player:startEvent(31) -- Start quest "Under the sea"
    else
        player:startEvent(153) -- Standard dialog
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 31 then
        player:addQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.UNDER_THE_SEA)
        player:setCharVar('underTheSeaVar', 1)
    end
end

return entity
