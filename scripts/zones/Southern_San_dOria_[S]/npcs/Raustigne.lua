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

    if (player:getQuestStatus(tpz.quest.log_id.CRYSTAL_WAR, tpz.quest.id.crystalWar.CLAWS_OF_THE_GRIFFON) == QUEST_COMPLETED and player:getCharVar("BoyAndTheBeast") == 0) then
        if (player:getCurrentMission(WOTG) == tpz.mission.id.wotg.CAIT_SITH or player:hasCompletedMission(tpz.mission.log_id.WOTG, tpz.mission.id.wotg.CAIT_SITH)) then
            player:startEvent(55)
        end
    else
        player:startEvent(606)
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
