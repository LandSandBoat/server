-----------------------------------
-- Area: Lower Jeuno
--  NPC: Zauko
-- Involved in Quests: Save the Clock Tower, Community Service
-- !pos -3 0 11 245
-----------------------------------
require("scripts/zones/Lower_Jeuno/globals")
local ID = require("scripts/zones/Lower_Jeuno/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
require("scripts/globals/quests")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------

function onTrade(player, npc, trade)

    ----- Save The Clock Tower Quest -----
    if (trade:hasItemQty(555, 1) == true and trade:getItemCount() == 1) then
        a = player:getCharVar("saveTheClockTowerNPCz2") -- NPC Zone2
        if (a == 0 or (a ~= 256 and a ~= 288 and a ~= 320 and a ~= 384 and a ~= 768 and a ~= 352 and a ~= 896 and a ~= 416 and
           a ~= 832 and a ~= 448 and a ~= 800 and a ~= 480 and a ~= 864 and a ~= 928 and a ~= 960 and a ~= 992)) then
            player:startEvent(50, 10 - player:getCharVar("saveTheClockTowerVar")) -- "Save the Clock Tower" Quest
        end
    end

end

function onTrigger(player, npc)

    local hour = VanadielHour()
    local playerOnQuestId = GetServerVariable("[JEUNO]CommService")
    local doneCommService = (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.COMMUNITY_SERVICE) == QUEST_COMPLETED) and 1 or 0
    local currCommService = player:getCharVar("currCommService")
    local hasMembershipCard = player:hasKeyItem(tpz.ki.LAMP_LIGHTERS_MEMBERSHIP_CARD) and 1 or 0

    local allLampsLit = true
    for i=0, 11 do
        local lamp = GetNPCByID(ID.npc.STREETLAMP_OFFSET + i)
        if (lamp:getAnimation() == tpz.anim.CLOSE_DOOR) then
            allLampsLit = false
            break
        end
    end

    -- quest has already been accepted.
    if (currCommService == 1) then
        if (playerOnQuestId ~= player:getID()) then
            player:startEvent(119) -- quest left over from previous day. fail quest.
        else
            if (hour >= 18 and hour < 21) then
                player:startEvent(115) -- tell player it's too early to start lighting lamps.
            elseif (allLampsLit) then
                player:startEvent(117, doneCommService) -- all lamps are lit. win quest.
            elseif (hour >= 21 or hour < 1) then
                player:startEvent(114) -- tell player they can start lighting lamps.
            else
                SetServerVariable("[JEUNO]CommService", -1) -- frees player from quest, but don't allow anyone else to take it today.
                player:startEvent(119) -- player didn't light lamps in time. fail quest.
            end
        end

    -- quest is available to player, nobody is currently on it, and the hour is right
    elseif (player:getFameLevel(JEUNO) >= 1 and playerOnQuestId == 0 and (hour >= 18 or hour < 1)) then
        player:startEvent(116, doneCommService)

    -- default dialog including option to drop membership card
    else
        player:startEvent(118, hasMembershipCard)

    end
end

function onEventUpdate(player, csid, option)
    if (csid == 116 and option == 0) then
        -- player accepts quest
        -- if nobody else has already been assigned to the quest, including Vhana, give it to this player

        local doneCommService = (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.COMMUNITY_SERVICE) == QUEST_COMPLETED) and 1 or 0
        local playerOnQuestId = GetServerVariable("[JEUNO]CommService")
        local hour = VanadielHour()

        if (playerOnQuestId == 0 and (hour >= 18 or hour < 1)) then
            -- nobody is currently on the quest
            SetServerVariable("[JEUNO]CommService", player:getID())
            player:addQuest(JEUNO, tpz.quest.id.jeuno.COMMUNITY_SERVICE)
            player:setCharVar("currCommService", 1)
            player:updateEvent(1, doneCommService)
        else
            -- either another player or vasha have been assigned the quest
            player:updateEvent(0, doneCommService)
        end
    end
end

function onEventFinish(player, csid, option)
    -- SAVE THE CLOCKTOWER
    if (csid == 50) then
        player:addCharVar("saveTheClockTowerVar", 1)
        player:addCharVar("saveTheClockTowerNPCz2", 256)

    -- COMMUNITY SERVICE
    elseif (csid == 117) then
        local params = {title = tpz.title.TORCHBEARER, var = "currCommService"}
        if (player:getQuestStatus(JEUNO, tpz.quest.id.jeuno.COMMUNITY_SERVICE) ~= QUEST_COMPLETED) then
            -- first victory
            params.fame = 30
        else
            -- repeat victory. offer membership card.
            params.fame = 15
            if (option == 1) then
                params.keyItem = tpz.ki.LAMP_LIGHTERS_MEMBERSHIP_CARD
            end
        end
        npcUtil.completeQuest(player, JEUNO, tpz.quest.id.jeuno.COMMUNITY_SERVICE, params)

    elseif (csid == 118 and option == 1) then
        -- player drops membership card
        player:delKeyItem(tpz.ki.LAMP_LIGHTERS_MEMBERSHIP_CARD)

    elseif (csid == 119) then
        -- player fails quest
        player:setCharVar("currCommService", 0)

    end
end
