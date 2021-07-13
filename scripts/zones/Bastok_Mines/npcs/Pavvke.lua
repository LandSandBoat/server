-----------------------------------
-- Area: Bastok Mines
--  NPC: Pavvke
-- Starts Quests: Fallen Comrades (100%)
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
local ID = require("scripts/zones/Bastok_Mines/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local count = trade:getItemCount()
    local SilverTag = trade:hasItemQty(13116, 1)
    local Fallen = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.FALLEN_COMRADES)

    if Fallen == 1 and SilverTag == true and count == 1 then
        player:tradeComplete()
        player:startEvent(91)
    elseif Fallen == 2 and SilverTag == true and count == 1 then
        player:tradeComplete()
        player:startEvent(92)
    end
end

entity.onTrigger = function(player, npc)
    local Fallen = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.FALLEN_COMRADES)
    local theEleventhsHour = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_ELEVENTH_S_HOUR)
    local pLevel = player:getMainLvl(player)
    local pFame = player:getFameLevel(BASTOK)

    if Fallen == 0 and pLevel >= 12 and pFame >= 2 then
        player:startEvent(90)
    else
        if theEleventhsHour == QUEST_ACCEPTED then
            player:startEvent(48)
        else
            player:startEvent(75)
        end
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
