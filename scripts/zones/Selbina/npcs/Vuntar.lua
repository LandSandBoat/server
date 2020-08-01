-----------------------------------
-- Area: Selbina
--  NPC: Vuntar
-- Starts and Finishes Quest: Cargo (R)
-- !pos 7 -2 -15 248
-----------------------------------
local ID = require("scripts/zones/Selbina/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
-----------------------------------

function onTrade(player, npc, trade)
    if player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.CARGO) ~= QUEST_AVAILABLE then
        if tonumber(os.date("%j")) ~= player:getCharVar("VuntarCanBuyItem_date") then
            if npcUtil.tradeHas(trade, 4529) then
                player:startEvent(52, 1) -- Can Buy rolanberry (881 ce)
            elseif npcUtil.tradeHas(trade, 4530) then
                player:startEvent(52, 2) -- Can Buy rolanberry (874 ce)
            elseif npcUtil.tradeHas(trade, 4531) then
                player:startEvent(52, 3) -- Can Buy rolanberry (864 ce)
            end
        else
            player:startEvent(1134, 4365) -- Can't buy rolanberrys
        end
    end
end

function onTrigger(player, npc)
    if player:getMainLvl() >= 20 and player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.CARGO) == QUEST_AVAILABLE then
        player:startEvent(50, 4365) -- Start quest "Cargo"
    elseif player:getMainLvl() < 20 then
        player:startEvent(53) -- Dialog for low level or low fame
    else
        player:startEvent(51, 4365) -- During & after completed quest "Cargo"
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 50 then
        player:addQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.CARGO)
    elseif csid == 52 then
        player:setCharVar("VuntarCanBuyItem_date", os.date("%j"))

        if player:getQuestStatus(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.CARGO) == QUEST_ACCEPTED then
            player:completeQuest(OTHER_AREAS_LOG, tpz.quest.id.otherAreas.CARGO)
            player:addFame(SELBINA, 30)
        end

        if option == 1 then
            player:addGil(800)
            player:messageSpecial(ID.text.GIL_OBTAINED, 800)
            player:confirmTrade()
        elseif option == 2 then
            player:addGil(2000)
            player:messageSpecial(ID.text.GIL_OBTAINED, 2000)
            player:confirmTrade()
        elseif option == 3 then
            player:addGil(3000)
            player:messageSpecial(ID.text.GIL_OBTAINED, 3000)
            player:confirmTrade()
        end
    end
end
