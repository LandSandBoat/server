-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Dkhaaya
-- Type: Standard NPC
-- !pos -73.212 -1 -5.842 50
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local olduumQuest = player:getQuestStatus(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.OLDUUM)
    local ringCheck = player:hasItem(2217)
    if olduumQuest == QUEST_AVAILABLE then
        player:startEvent(4)
    elseif player:hasKeyItem(xi.ki.ELECTROLOCOMOTIVE) or player:hasKeyItem(xi.ki.ELECTROPOT) or player:hasKeyItem(xi.ki.ELECTROCELL) and ringCheck == false then
        if olduumQuest == QUEST_ACCEPTED then
            player:startEvent(6)
        else
            player:startEvent(8)
        end
    elseif olduumQuest ~= QUEST_AVAILABLE and ringCheck == false then
        player:startEvent(5)
    else
        player:startEvent(7)

    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if csid == 4 then
        player:addKeyItem(xi.ki.DKHAAYAS_RESEARCH_JOURNAL)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.DKHAAYAS_RESEARCH_JOURNAL)
        player:addQuest(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.OLDUUM)
    elseif csid == 6 or csid == 8 then
        if player:getFreeSlotsCount() >= 1 then
            player:addItem(2217)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 2217)
            player:delKeyItem(xi.ki.DKHAAYAS_RESEARCH_JOURNAL)
            player:delKeyItem(xi.ki.ELECTROLOCOMOTIVE)
            player:delKeyItem(xi.ki.ELECTROPOT)
            player:delKeyItem(xi.ki.ELECTROCELL)
            if csid == 6 then
                player:completeQuest(xi.quest.log_id.AHT_URHGAN, xi.quest.id.ahtUrhgan.OLDUUM)
            end
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 2217)
        end

    end
end

return entity
