-----------------------------------
-- Area: Mhaura
--  NPC: Numi Adaligo
--  Involved In Quest: RYCHARDE_THE_CHEF
-----------------------------------
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local rovOptionEnable = 0
    if player:getCurrentMission(ROV) == tpz.mission.id.rov.EMISSARY_FROM_THE_SEAS and player:getCharVar("RhapsodiesStatus") == 2 then
        rovOptionEnable = 1
    end
    player:startEvent(50, 0, 0, 0, 0, 0, 0, 0, rovOptionEnable)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    local RychardetheChef = player:getQuestStatus(tpz.quest.log_id.OTHER_AREAS, tpz.quest.id.otherAreas.RYCHARDE_THE_CHEF)
    local QuestStatus=player:getCharVar("QuestRychardetheChef_var")

    if ((option == 2) and (RychardetheChef == QUEST_AVAILABLE) and (tonumber(QuestStatus) == 0)) then
        player:setCharVar("QuestRychardetheChef_var", 1);  -- first stage of rycharde the chef quest
    elseif csid == 50 and option == 1 then
        player:completeMission(ROV, tpz.mission.id.rov.EMISSARY_FROM_THE_SEAS)
        player:addMission(ROV, tpz.mission.id.rov.SET_FREE)
    end

end
