-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Akta
-----------------------------------
local ID = require("scripts/zones/RuLude_Gardens/IDs")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local fellowQuest = player:getCharVar("[Quest]Unlisted_Qualities")
    if
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.UNLISTED_QUALITIES) == QUEST_ACCEPTED and
        not utils.mask.getBit(fellowQuest, 0)
    then
        player:startEvent(10103, 0, 0, 0, 0, 0, 0, 0, player:getFellowValue("fellowid"))
    else
        player:startEvent(116)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if
        csid == 10103 and
        option >= 1 and option <= 3
    then
        player:setFellowValue("size", option * 4)
        player:setCharVar("[Quest]Unlisted_Qualities", utils.mask.setBit(player:getCharVar("[Quest]Unlisted_Qualities"), 0, true))
    end

    --[[
    Adventuring Fellow Size Options:
        3   Pretty tall
        2   Around average
        1   On the small side
    --]]
end

return entity
