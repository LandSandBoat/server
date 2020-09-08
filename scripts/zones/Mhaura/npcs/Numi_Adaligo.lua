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
    player:startEvent(50)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    local RychardetheChef = player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.RYCHARDE_THE_CHEF)
    local QuestStatus=player:getCharVar("QuestRychardetheChef_var")

    if ((option == 2) and (RychardetheChef == QUEST_AVAILABLE) and (tonumber(QuestStatus) == 0)) then
        player:setCharVar("QuestRychardetheChef_var", 1)  -- first stage of rycharde the chef quest
    end

end
