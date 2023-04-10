-----------------------------------
-- Area: Upper Jeuno
--  NPC: Monberaux
-- Starts and Finishes Quest: The Lost Cardian (finish), The kind cardian (start)
-- Involved in Quests: Save the Clock Tower
-- !pos -43 0 -1 244
-----------------------------------
local ID = require("scripts/zones/Upper_Jeuno/IDs")
require("scripts/globals/settings")
require("scripts/globals/titles")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local theLostCardien = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_LOST_CARDIAN)
    local cooksPride = player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.COOK_S_PRIDE)

    if
        cooksPride == QUEST_COMPLETED and
        theLostCardien == QUEST_AVAILABLE and
        player:getCharVar("theLostCardianVar") == 2
    then
        player:startEvent(33) -- Long CS & Finish Quest "The Lost Cardian"

    elseif
        cooksPride == QUEST_COMPLETED and
        theLostCardien == QUEST_AVAILABLE and
        player:getCharVar("theLostCardianVar") == 3
    then
        player:startEvent(34) -- Shot CS & Finish Quest "The Lost Cardian"

    elseif
        theLostCardien == QUEST_COMPLETED and
        player:getQuestStatus(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_KIND_CARDIAN) == QUEST_ACCEPTED
    then
        player:startEvent(32)
    end
end

--Door:Infirmary     2 ++
--Door:Infirmary     10 ++
--Door:Infirmary     207 ++
--Door:Infirmary     82 ++
--Door:Infirmary     10059 nonCOP
--Door:Infirmary     10060 nonCOP
--Door:Infirmary     10205 nonCOP
--Door:Infirmary     10061 nonCOP
--Door:Infirmary     10062 nonCOP
--Door:Infirmary     10207 nonCOP
--Door:Infirmary     33 ++
--Door:Infirmary     34 ++
--Door:Infirmary     2 ++
--Door:Infirmary     82 ++
--Door:Infirmary     75 ++
--Door:Infirmary     10060 nonCOP
--Door:Infirmary     10205 nonCOP

--Tenzen     10011
--Tenzen     10012

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if
        (csid == 33 and option == 0) or
        (csid == 34 and option == 0)
    then
        player:addTitle(xi.title.TWOS_COMPANY)
        player:setCharVar("theLostCardianVar", 0)
        npcUtil.giveCurrency(player, 'gil', 2100)
        player:addKeyItem(xi.ki.TWO_OF_SWORDS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.TWO_OF_SWORDS) -- Two of Swords (Key Item)
        player:addFame(xi.quest.fame_area.JEUNO, 30)
        player:completeQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_LOST_CARDIAN)
        player:addQuest(xi.quest.log_id.JEUNO, xi.quest.id.jeuno.THE_KIND_CARDIAN) -- Start next quest "THE_KING_CARDIAN"
    elseif csid == 33 and option == 1 then
        player:setCharVar("theLostCardianVar", 3)
    end
end

return entity
