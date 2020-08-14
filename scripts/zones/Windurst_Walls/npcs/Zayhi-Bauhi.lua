-----------------------------------
-- Area: Windurst Walls
--  Location: X:-91  Y:-9  Z:109
--  NPC: Zayhi-Bauhi
--    Working 100%
--  Starts and Finishes Quest: To Bee or Not to Bee?
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if (player:getQuestStatus(WINDURST, tpz.quest.id.windurst.TO_BEE_OR_NOT_TO_BEE) == QUEST_ACCEPTED) then
        if (trade:hasItemQty(4370, 1) and trade:getItemCount() == 1) then
            local ToBeeOrNotStatus = player:getCharVar("ToBeeOrNot_var")
            if (ToBeeOrNotStatus == 10) then
                player:startEvent(69) -- After Honey#1: Clearing throat
            elseif (ToBeeOrNotStatus == 1) then
                player:startEvent(70) -- After Honey#2: Tries to speak again... coughs
            elseif (ToBeeOrNotStatus == 2) then
                player:startEvent(73) -- After Honey#3: Tries to speak again... coughs..asked for more Honey
            elseif (ToBeeOrNotStatus == 3) then
                player:startEvent(74) -- After Honey#4: Feels like its getting a lot better but there is still iritaion
            elseif (ToBeeOrNotStatus == 4) then
                player:startEvent(75) -- After Honey#5: ToBee quest Finish (tooth hurts from all the Honey
            end
        end
    end
end

function onTrigger(player, npc)
    local ToBee = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.TO_BEE_OR_NOT_TO_BEE)
    local PostmanKOsTwice = player:getQuestStatus(WINDURST, tpz.quest.id.windurst.THE_POSTMAN_ALWAYS_KO_S_TWICE)
    local ToBeeOrNotStatus = player:getCharVar("ToBeeOrNot_var")

    if ((player:getFameLevel(WINDURST) >= 2 and PostmanKOsTwice == QUEST_COMPLETED and ToBee == QUEST_AVAILABLE) or (ToBee == QUEST_ACCEPTED and ToBeeOrNotStatus == 10)) then
        player:startEvent(64)   -- Just Before Quest Start "Too Bee or Not Too Be" (Speech given with lots of coughing)
    elseif (ToBee == QUEST_ACCEPTED) then
        if (ToBeeOrNotStatus == 1) then
            player:startEvent(69) -- After Honey#1: Clearing throat
        elseif (ToBeeOrNotStatus == 2) then
            player:startEvent(70) -- After Honey#2: Tries to speak again... coughs
        elseif (ToBeeOrNotStatus == 3) then
            player:startEvent(73) -- After Honey#3: Tries to speak again... coughs..asked for more Honey
        elseif (ToBeeOrNotStatus == 4) then
            player:startEvent(74) -- After Honey#4: Feels like its getting a lot better but there is still iritaion
        end
    elseif (ToBee == QUEST_COMPLETED and player:needToZone()) then
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
function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 64) then
        player:setCharVar("ToBeeOrNot_var", 10)
    elseif (csid == 69) then -- After Honey#1: Clearing throat
        player:tradeComplete()
        player:setCharVar("ToBeeOrNot_var", 1)
    elseif (csid == 70) then -- After Honey#2: Tries to speak again... coughs
        player:tradeComplete()
        player:setCharVar("ToBeeOrNot_var", 2)
    elseif (csid == 73) then -- After Honey#3: Tries to speak again... coughs..asked for more Honey
        player:tradeComplete()
        player:setCharVar("ToBeeOrNot_var", 3)
    elseif (csid == 74) then -- After Honey#4: Feels like its getting a lot better but there is still iritaion
        player:tradeComplete()
        player:setCharVar("ToBeeOrNot_var", 4)
    elseif (csid == 75) then -- After Honey#5: ToBee quest Finish (tooth hurts from all the Honey)
        player:tradeComplete()
        player:setCharVar("ToBeeOrNot_var", 5)
        player:addFame(WINDURST, 30)
        player:completeQuest(WINDURST, tpz.quest.id.windurst.TO_BEE_OR_NOT_TO_BEE)
        player:needToZone(true)
    end
end
