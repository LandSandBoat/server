-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Zabahf
-- Type: Standard NPC
-- !pos -90.070 -1 10.140 50
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local gotItAllProg = player:getCharVar("gotitallCS")
    if gotItAllProg == 1 or gotItAllProg == 3 then
        player:startEvent(533)
    elseif gotItAllProg == 2 then
        player:startEvent(523)
    elseif gotItAllProg == 5 then
        player:startEvent(538)
    elseif gotItAllProg == 6 then
        player:startEvent(540)
    elseif gotItAllProg == 7 then
        player:startEvent(535)
    elseif player:getQuestStatus(tpz.quest.log_id.AHT_URHGAN, tpz.quest.id.ahtUrhgan.GOT_IT_ALL) == QUEST_COMPLETED then
        player:startEvent(530)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 523 then
        player:setCharVar("gotitallCS", 3)
    end
end

return entity
