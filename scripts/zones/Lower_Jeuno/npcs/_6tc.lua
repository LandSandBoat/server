-----------------------------------
-- Area: Lower Jeuno
--  NPC: Door: "Neptune's Spire"
-- Starts and Finishes Quest: Beat Around the Bushin
-- ZM 17 cutscene
-- !pos 35 0 -15 245
-----------------------------------
local ID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.BEAT_AROUND_THE_BUSHIN) == xi.questStatus.QUEST_ACCEPTED then
        if
            trade:hasItemQty(xi.item.WYRM_BEARD, 1) and
            trade:getItemCount() == 1 and
            player:getCharVar('BeatAroundTheBushin') == 2
        then
            player:startEvent(156) -- After trade Wyrm Beard

        elseif
            trade:hasItemQty(xi.item.BEHEMOTH_TONGUE, 1) and
            trade:getItemCount() == 1 and
            player:getCharVar('BeatAroundTheBushin') == 4
        then
            player:startEvent(157) -- After trade Behemoth Tongue

        elseif
            trade:hasItemQty(xi.item.ADAMANTOISE_EGG, 1) and
            trade:getItemCount() == 1 and
            player:getCharVar('BeatAroundTheBushin') == 6
        then
            player:startEvent(158) -- After trade Adamantoise Egg

        elseif
            trade:hasItemQty(xi.item.BROWN_BELT, 1) and
            trade:getItemCount() == 1 and
            player:getCharVar('BeatAroundTheBushin') == 7
        then
            player:startEvent(159) -- After trade Brown Belt, Finish Quest "Beat around the Bushin"
        end
    end
end

entity.onTrigger = function(player, npc)
    if player:getCharVar('BeatAroundTheBushin') == 1 then
        player:startEvent(155) -- Start Quest "Beat around the Bushin"

    elseif player:hasKeyItem(xi.ki.TENSHODO_MEMBERS_CARD) then
        player:startEvent(105) -- Open the door

    else
        player:messageSpecial(ID.text.ITS_LOCKED)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 155 then
        player:addQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.BEAT_AROUND_THE_BUSHIN)
        player:setCharVar('BeatAroundTheBushin', 2)
    elseif csid == 156 then
        player:setCharVar('BeatAroundTheBushin', 3)
        player:tradeComplete()
    elseif csid == 157 then
        player:setCharVar('BeatAroundTheBushin', 5)
        player:tradeComplete()
    elseif csid == 158 then
        player:setCharVar('BeatAroundTheBushin', 7)
        player:tradeComplete()
    elseif csid == 159 then
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.BLACK_BELT)
        else
            player:addTitle(xi.title.BLACK_BELT)
            player:addItem(xi.item.BLACK_BELT)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.BLACK_BELT)
            player:setCharVar('BeatAroundTheBushin', 0)
            player:addFame(xi.fameArea.NORG, 125)
            player:tradeComplete()
            player:completeQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.BEAT_AROUND_THE_BUSHIN)
        end
    end
end

return entity
