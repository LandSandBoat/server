-----------------------------------
-- Area: Windurst Walls
--  Location: X:-91  Y:-9  Z:109
--  NPC: Zayhi-Bauhi
--  Starts and Finishes Quest: To Bee or Not to Bee?
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.TO_BEE_OR_NOT_TO_BEE) == xi.questStatus.QUEST_ACCEPTED then
        if trade:hasItemQty(xi.item.POT_OF_HONEY, 1) and trade:getItemCount() == 1 then
            local toBeeOrNotStatus = player:getCharVar('ToBeeOrNot_var')
            if toBeeOrNotStatus == 10 then
                player:startEvent(69) -- After Honey#1: Clearing throat
            elseif toBeeOrNotStatus == 1 then
                player:startEvent(70) -- After Honey#2: Tries to speak again... coughs
            elseif toBeeOrNotStatus == 2 then
                player:startEvent(73) -- After Honey#3: Tries to speak again... coughs..asked for more Honey
            elseif toBeeOrNotStatus == 3 then
                player:startEvent(74) -- After Honey#4: Feels like its getting a lot better but there is still iritaion
            elseif toBeeOrNotStatus == 4 then
                player:startEvent(75) -- After Honey#5: ToBee quest Finish (tooth hurts from all the Honey
            end
        end
    end
end

entity.onTrigger = function(player, npc)
    local toBee = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.TO_BEE_OR_NOT_TO_BEE)
    local postmanKOsTwice = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.THE_POSTMAN_ALWAYS_KOS_TWICE)
    local toBeeOrNotStatus = player:getCharVar('ToBeeOrNot_var')

    if
        (player:getFameLevel(xi.fameArea.WINDURST) >= 2 and postmanKOsTwice == xi.questStatus.QUEST_COMPLETED and toBee == xi.questStatus.QUEST_AVAILABLE) or
        (toBee == xi.questStatus.QUEST_ACCEPTED and toBeeOrNotStatus == 10)
    then
        player:startEvent(64)   -- Just Before Quest Start 'Too Bee or Not Too Be' (Speech given with lots of coughing)
    elseif toBee == xi.questStatus.QUEST_ACCEPTED then
        if toBeeOrNotStatus == 1 then
            player:startEvent(69) -- After Honey#1: Clearing throat
        elseif toBeeOrNotStatus == 2 then
            player:startEvent(70) -- After Honey#2: Tries to speak again... coughs
        elseif toBeeOrNotStatus == 3 then
            player:startEvent(73) -- After Honey#3: Tries to speak again... coughs..asked for more Honey
        elseif toBeeOrNotStatus == 4 then
            player:startEvent(74) -- After Honey#4: Feels like its getting a lot better but there is still iritaion
        end
    elseif toBee == xi.questStatus.QUEST_COMPLETED and player:needToZone() then
        player:startEvent(78) -- ToBee After Quest Finish but before zone (tooth still hurts)
    else
        player:startEvent(299) -- Normal speech
    end
end

--        Event ID List for NPC
--      player:startEvent(299) -- Normal speach
--      player:startEvent(61) -- Normal speach
--      player:startEvent(64) -- Start quest "Too Bee or Not Too Be" (Speech given with lots of coughing)
--      player:startEvent(69) -- After Honey#1: Clearing throat
--      player:startEvent(70) -- After Honey#2: Tries to speak again... coughs
--      player:startEvent(73) -- After Honey#3: Tries to speak again... coughs..asked for more Honey
--      player:startEvent(74) -- After Honey#4: Feels like its getting a lot better but there is still iritaion
--      player:startEvent(75) -- After Honey#5: ToBee quest Finish (tooth hurts from all the Honey)
--      player:startEvent(78) -- ToBee After Quest Finish but before zone (tooth still hurts)

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 64 then
        player:setCharVar('ToBeeOrNot_var', 10)
    elseif csid == 69 then -- After Honey#1: Clearing throat
        player:tradeComplete()
        player:setCharVar('ToBeeOrNot_var', 1)
    elseif csid == 70 then -- After Honey#2: Tries to speak again... coughs
        player:tradeComplete()
        player:setCharVar('ToBeeOrNot_var', 2)
    elseif csid == 73 then -- After Honey#3: Tries to speak again... coughs..asked for more Honey
        player:tradeComplete()
        player:setCharVar('ToBeeOrNot_var', 3)
    elseif csid == 74 then -- After Honey#4: Feels like its getting a lot better but there is still iritaion
        player:tradeComplete()
        player:setCharVar('ToBeeOrNot_var', 4)
    elseif csid == 75 then -- After Honey#5: ToBee quest Finish (tooth hurts from all the Honey)
        player:tradeComplete()
        player:setCharVar('ToBeeOrNot_var', 5)
        player:addFame(xi.fameArea.WINDURST, 30)
        player:completeQuest(xi.questLog.WINDURST, xi.quest.id.windurst.TO_BEE_OR_NOT_TO_BEE)
        player:needToZone(true)
    end
end

return entity
