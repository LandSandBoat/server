-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Rholont
-- !pos -168 -2 56 80
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria_[S]/IDs")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if (player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.BOY_AND_THE_BEAST) == QUEST_COMPLETED and player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.WRATH_OF_THE_GRIFFON) == QUEST_AVAILABLE) then
        player:startEvent(59)
    elseif (player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.WRATH_OF_THE_GRIFFON) == QUEST_ACCEPTED) then
        if (player:getCharVar("WrathOfTheGriffon") < 2) then
            player:startEvent(61)
        elseif (player:getCharVar("WrathOfTheGriffon") == 2) then
            player:startEvent(60)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 59) then
        player:addQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.WRATH_OF_THE_GRIFFON)
    elseif (csid == 60) then
        player:completeQuest(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.WRATH_OF_THE_GRIFFON)
        player:setCharVar("WrathOfTheGriffon", 0)
        player:addKeyItem(xi.ki.MILITARY_SCRIP)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.MILITARY_SCRIP)
    end
end

return entity
