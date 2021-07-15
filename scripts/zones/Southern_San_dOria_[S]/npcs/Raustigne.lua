-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Raustigne
-- !pos 4 -2 44 80
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.CLAWS_OF_THE_GRIFFON) == QUEST_COMPLETED and player:getCharVar("BoyAndTheBeast") == 0) then
        if (player:getCurrentMission(WOTG) == xi.mission.id.wotg.CAIT_SITH or player:hasCompletedMission(xi.mission.log_id.WOTG, xi.mission.id.wotg.CAIT_SITH)) then
            player:startEvent(55)
        end
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 55) then
        player:setCharVar("BoyAndTheBeast", 1)
    end
end

return entity
