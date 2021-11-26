-----------------------------------
-- Area: Bastok Mines
--  NPC: Pavvke
-- Starts Quests: Fallen Comrades (100%)
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/quests")
require("scripts/settings/main")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local Fallen = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.FALLEN_COMRADES)

    if
        trade:hasItemQty(13116, 1) == true and
        trade:getItemCount() == 1
    then
        if Fallen == 1 then
            player:tradeComplete()
            player:startEvent(91)
        elseif Fallen == 2 then
            player:tradeComplete()
            player:startEvent(92)
        end
    end
end

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.FALLEN_COMRADES) == 0 and
        player:getMainLvl(player) >= 12 and
        player:getFameLevel(BASTOK) >= 2
    then
        player:startEvent(90)

    elseif player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_ELEVENTH_S_HOUR) == QUEST_ACCEPTED then
        player:startEvent(48)
    else
        player:startEvent(75)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 90 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.FALLEN_COMRADES)
    elseif csid == 91 then
        player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.FALLEN_COMRADES)
        player:addFame(BASTOK, 120)
        player:addGil(xi.settings.GIL_RATE * 550)
        player:messageSpecial(ID.text.GIL_OBTAINED, xi.settings.GIL_RATE * 550)
    elseif csid == 92 then
        player:addFame(BASTOK, 8)
        player:addGil(xi.settings.GIL_RATE * 550)
        player:messageSpecial(ID.text.GIL_OBTAINED, xi.settings.GIL_RATE * 550)
    end
end

return entity
