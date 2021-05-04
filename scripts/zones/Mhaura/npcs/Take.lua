-----------------------------------
-- Area: Mhaura
-- NPC: Take
-- Starts and finishes quest: Expertice
-----------------------------------
-- Used in: scripts/quests/otherAreas/Rycharde_the_Chef.lua
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/quests")
require("scripts/globals/settings")
local ID = require("scripts/zones/Mhaura/IDs")
-----------------------------------
local entity = {}

-- player:startEvent(59) -- standar dialog
-- player:startEvent(60) -- tell to look for ricarde
-- player:startEvent(68) -- not talked to rycharde yet
-- player:startEvent(61)-- accept expertice quest
-- player:startEvent(62)-- expertice completed
-- player:startEvent(63)-- expertice not done yet
-- player:startEvent(64) -- after expertice quest
-- player:startEvent(65) -- good luck
-- player:startEvent(66)-- Valgeir cook was delicious
-- player:startEvent(67)-- after back to basics i think

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.EXPERTISE)==QUEST_COMPLETED and player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_CLUE)==QUEST_AVAILABLE) then --
        player:startEvent(64) -- after expertice quest
    elseif (player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_CLUE)==QUEST_ACCEPTED) then--
        player:startEvent(65) -- good luck
    elseif (player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_CLUE)==QUEST_COMPLETED and player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_BASICS)==QUEST_AVAILABLE) then --
        player:startEvent(66)-- Valgeir cook was delicious
    elseif (player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.THE_BASICS)==QUEST_COMPLETED) then--
        player:startEvent(67)-- after back to basics i think
    else
        player:startEvent(59) -- talk abaout something else
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
