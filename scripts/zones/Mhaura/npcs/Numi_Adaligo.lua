-----------------------------------
-- Area: Mhaura
--  NPC: Numi Adaligo
--  Involved In Quest: RYCHARDE_THE_CHEF
-----------------------------------
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local rovOptionEnable = 0
    if player:getCurrentMission(ROV) == xi.mission.id.rov.EMISSARY_FROM_THE_SEAS and player:getCharVar("RhapsodiesStatus") == 2 then
        rovOptionEnable = 1
    end
    player:startEvent(50, 0, 0, 0, 0, 0, 0, 0, rovOptionEnable)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    local RychardetheChef = player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.RYCHARDE_THE_CHEF)
    local QuestStatus=player:getCharVar("QuestRychardetheChef_var")

    if ((option == 2) and (RychardetheChef == QUEST_AVAILABLE) and (tonumber(QuestStatus) == 0)) then
        player:setCharVar("QuestRychardetheChef_var", 1);  -- first stage of rycharde the chef quest
    elseif csid == 50 and option == 1 then
        player:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.EMISSARY_FROM_THE_SEAS)
        player:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.SET_FREE)
    end

end

return entity
