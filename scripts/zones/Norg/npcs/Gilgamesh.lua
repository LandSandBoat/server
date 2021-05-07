-----------------------------------
-- Area: Norg
--  NPC: Gilgamesh
-- !pos 122.452 -9.009 -12.052 252
-----------------------------------
local ID = require("scripts/zones/Norg/IDs")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)

    if (player:getCurrentMission(BASTOK) == xi.mission.id.bastok.THE_PIRATE_S_COVE and
        player:getMissionStatus(player:getNation()) == 2) then
        if (trade:hasItemQty(1160, 1) and trade:getItemCount() == 1) then -- Frag Rock
            player:startEvent(99) -- Bastok Mission 6-2
        end
    end

end

entity.onTrigger = function(player, npc)
    local ZilartMission = player:getCurrentMission(ZILART)
    local rovMission = player:getCurrentMission(ROV)

    if player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH) == QUEST_ACCEPTED and
        player:getCharVar('ApocalypseNigh') == 6 and player:getCharVar('Apoc_Nigh_RewardCS1') == 0 then
        player:startEvent(232, 252)
    elseif player:getCharVar('Apoc_Nigh_RewardCS1') == 1 then
        player:startEvent(234, 252)
    elseif player:hasCompletedQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH) then
        player:startEvent(233);
    elseif rovMission == xi.mission.id.rov.THE_PATH_UNTRAVELED then
        player:startEvent(263)
    end
end

entity.onEventUpdate = function(player, csid, option)
    if (csid == 232 or csid == 234) and option == 99 then
        player:updateEvent(252, 15962, 15963, 15964, 15965)
    end
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 99) then
        player:tradeComplete()
        player:setMissionStatus(player:getNation(), 3)
    elseif csid == 232 or csid == 234 then
        if csid == 232 then
            player:setCharVar("Apoc_Nigh_RewardCS1", 1)
        end

        local reward = 0
        if option == 1 then
            reward = 15962 -- Static Earring
        elseif option == 2 then
            reward = 15963 -- Magnetic Earring
        elseif option == 3 then
            reward = 15964 -- Hollow Earring
        elseif option == 4 then
            reward = 15965 -- Ethereal Earring
        end

        if reward ~= 0 then
            if npcUtil.completeQuest(player, JEUNO, xi.quest.id.jeuno.APOCALYPSE_NIGH, {
                item = reward,
                var = {"ApocalypseNigh", "Apoc_Nigh_Reward", "Apoc_Nigh_RewardCS1"}
            }) then
                player:completeMission(xi.mission.log_id.COP, xi.mission.id.cop.DAWN)
                player:addMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_LAST_VERSE)
                player:setCharVar("PromathiaStatus", 0)
                player:completeMission(xi.mission.log_id.ZILART, xi.mission.id.cop.AWAKENING)
                player:addMission(xi.mission.log_id.ZILART, xi.mission.id.zilart.THE_LAST_VERSE)
                player:setMissionStatus(xi.mission.log_id.ZILART, 0)
            end
        end
    end
end

return entity
