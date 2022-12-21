-----------------------------------
-- Area: Kazham
--  NPC: Hari Pakhroib
-- Starts and Finishes Quest: Greetings to the Guardian
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
require("scripts/globals/titles")
local ID = require("scripts/zones/Kazham/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local guardian = player:getQuestStatus(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.GREETINGS_TO_THE_GUARDIAN)
    local pamamas = player:getCharVar("PamamaVar")
    local pfame = player:getFameLevel(xi.quest.fame_area.WINDURST)
    local needToZone = player:needToZone()

    if guardian == QUEST_ACCEPTED then
        if pamamas == 1 then
            player:startEvent(71) --Finish Quest
        else
            player:startEvent(69, 0, 4596) --Reminder Dialogue
        end
    elseif guardian == QUEST_AVAILABLE and pfame >= 7 then
        player:startEvent(68, 4596, 4596, 4596) --Start Quest
    elseif guardian == QUEST_COMPLETED and not needToZone then
        if pamamas == 2 then
            player:startEvent(71) --Finish quest dialogue (no different csid between initial and repeats)
        else
            player:startEvent(72) --Dialogue for after completion of quest
        end
    elseif guardian == QUEST_COMPLETED and needToZone then
        player:startEvent(72)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 68 and option == 1 then
        player:addQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.GREETINGS_TO_THE_GUARDIAN)
        player:setCharVar("PamamaVar", 0)
    elseif csid == 71 then
        local pamamas = player:getCharVar("PamamaVar")
        if pamamas == 1 then --First completion of quest; set title, complete quest, and give higher fame
            npcUtil.giveCurrency(player, 'gil', 5000)
            player:completeQuest(xi.quest.log_id.OUTLANDS, xi.quest.id.outlands.GREETINGS_TO_THE_GUARDIAN)
            player:addFame(xi.quest.fame_area.WINDURST, 100)
            player:addTitle(xi.title.KAZHAM_CALLER)
            player:setCharVar("PamamaVar", 0)
            player:needToZone(true)
        elseif pamamas == 2 then --Repeats of quest; give only gil and less fame
            npcUtil.giveCurrency(player, 'gil', 5000)
            player:addFame(xi.quest.fame_area.WINDURST, 30)
            player:setCharVar("PamamaVar", 0)
            player:needToZone(true)
        end
    end
end

return entity
