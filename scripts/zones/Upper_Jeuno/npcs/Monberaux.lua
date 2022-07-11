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
    if trade:hasItemQty(555, 1) == true and trade:getItemCount() == 1 then
        local a = player:getCharVar("saveTheClockTowerNPCz1") -- NPC Part1
        if
            a == 0 or
            (
                a ~= 4 and
                a ~= 5 and
                a ~= 6 and
                a ~= 12 and
                a ~= 20 and
                a ~= 7 and
                a ~= 28 and
                a ~= 13 and
                a ~= 22 and
                a ~= 14 and
                a ~= 21 and
                a ~= 15 and
                a ~= 23 and
                a ~= 29 and
                a ~= 30 and
                a ~= 31
            )
        then
            player:startEvent(91, 10 - player:getCharVar("saveTheClockTowerVar")) -- "Save the Clock Tower" Quest
        end
    end
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
    if csid == 91 then
        player:addCharVar("saveTheClockTowerVar", 1)
        player:addCharVar("saveTheClockTowerNPCz1", 4)
    elseif
        (csid == 33 and option == 0) or
        (csid == 34 and option == 0)
    then
        player:addTitle(xi.title.TWOS_COMPANY)
        player:setCharVar("theLostCardianVar", 0)
        player:addGil(xi.settings.main.GIL_RATE*2100)
        player:messageSpecial(ID.text.GIL_OBTAINED, xi.settings.main.GIL_RATE*2100)
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
