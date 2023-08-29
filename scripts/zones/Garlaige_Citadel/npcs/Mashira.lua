-----------------------------------
-- Area: Garlaige Citadel
--  NPC: Mashira
-- Involved in Quests: Rubbish day, Making Amens!
-- !pos 141 -6 138 200
-----------------------------------
require("scripts/globals/quests")
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Note: You cannot simply Tractor through the door.
    -- https://ffxiclopedia.fandom.com/wiki/Making_Amens!
    -- https://ffxiclopedia.fandom.com/wiki/Rubbish_Day
    if player:getLocalVar('hatchOpened') == 0 then
        return
    end

    local rubbishDay =  player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.RUBBISH_DAY) == QUEST_ACCEPTED and player:getCharVar("RubbishDayVar") == 0

    if rubbishDay then
        player:startEvent(11, 1)
    else
        player:startEvent(11, 3)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local rubbishDay = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.RUBBISH_DAY)
    if csid == 11 and option == 1 and rubbishDay == QUEST_ACCEPTED then
        player:delKeyItem(xi.ki.MAGIC_TRASH)
        player:setCharVar("RubbishDayVar", 1)
    end
end

return entity
