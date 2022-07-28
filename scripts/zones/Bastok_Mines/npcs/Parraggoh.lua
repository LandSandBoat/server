-----------------------------------
-- Area: Bastok Mines
--  NPC: Parraggoh
-- Finishes Quest: Beauty and the Galka
-----------------------------------
local ID = require("scripts/zones/Bastok_Mines/IDs")
require("scripts/globals/quests")
require("scripts/globals/keyitems")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local beautyAndTheGalka = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BEAUTY_AND_THE_GALKA)

    -- Beauty and the Galka
    if player:hasKeyItem(xi.ki.PALBOROUGH_MINES_LOGS) then
        player:startEvent(10)

    elseif beautyAndTheGalka == QUEST_ACCEPTED then
        if math.random(2) == 1 then
            player:startEvent(8)
        else
            player:startEvent(9)
        end

    elseif player:getCharVar("BeautyAndTheGalkaDenied") == 1 then
        player:startEvent(7)

    -- The eleventh's hour
    elseif beautyAndTheGalka == QUEST_COMPLETED then
        if player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.THE_ELEVENTH_S_HOUR) == QUEST_ACCEPTED then
            player:startEvent(46)
        else
            player:startEvent(12)
        end
    else
        player:startEvent(11)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 7 and option == 0 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BEAUTY_AND_THE_GALKA)
    elseif csid == 10 then
        if player:getFreeSlotsCount() >= 1 then
            player:completeQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.BEAUTY_AND_THE_GALKA)
            player:setCharVar("BeautyAndTheGalkaDenied", 0)
            player:delKeyItem(xi.ki.PALBOROUGH_MINES_LOGS)
            player:addFame(xi.quest.fame_area.BASTOK, 75)
            player:addItem(16465)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 16465)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 16465)
        end
    end
end

return entity
