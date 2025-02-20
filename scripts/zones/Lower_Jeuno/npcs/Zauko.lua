-----------------------------------
-- Area: Lower Jeuno
--  NPC: Zauko
-- Involved in Quests: Community Service
-- !pos -3 0 11 245
-----------------------------------
require('scripts/zones/Lower_Jeuno/globals')
local ID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local hour              = VanadielHour()
    local playerOnQuestId   = GetServerVariable('[JEUNO]CommService')
    local doneCommService   = (player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.COMMUNITY_SERVICE) == xi.questStatus.QUEST_COMPLETED) and 1 or 0
    local currCommService   = player:getCharVar('currCommService')
    local hasMembershipCard = player:hasKeyItem(xi.ki.LAMP_LIGHTERS_MEMBERSHIP_CARD) and 1 or 0

    local allLampsLit = true
    for i = 0, 11 do
        local lamp = GetNPCByID(ID.npc.STREETLAMP_OFFSET + i)
        if lamp and lamp:getAnimation() == xi.anim.CLOSE_DOOR then
            allLampsLit = false
            break
        end
    end

    -- quest has already been accepted.
    if currCommService == 1 then
        if playerOnQuestId ~= player:getID() then
            player:startEvent(119) -- quest left over from previous day. fail quest.
        else
            if hour >= 18 and hour < 21 then
                player:startEvent(115) -- tell player it's too early to start lighting lamps.
            elseif allLampsLit then
                player:startEvent(117, doneCommService) -- all lamps are lit. win quest.
            elseif hour >= 21 or hour < 1 then
                player:startEvent(114) -- tell player they can start lighting lamps.
            else
                SetServerVariable('[JEUNO]CommService', -1) -- frees player from quest, but don't allow anyone else to take it today.
                player:startEvent(119) -- player didn't light lamps in time. fail quest.
            end
        end

    -- quest is available to player, nobody is currently on it, and the hour is right
    elseif
        player:getFameLevel(xi.fameArea.JEUNO) >= 1 and
        playerOnQuestId == 0 and
        (hour >= 18 or hour < 1)
    then
        player:startEvent(116, doneCommService)

    -- default dialog including option to drop membership card
    else
        player:startEvent(118, hasMembershipCard)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 116 and option == 0 then
        -- player accepts quest
        -- if nobody else has already been assigned to the quest, including Vhana, give it to this player

        local doneCommService = (player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.COMMUNITY_SERVICE) == xi.questStatus.QUEST_COMPLETED) and 1 or 0
        local playerOnQuestId = GetServerVariable('[JEUNO]CommService')
        local hour = VanadielHour()

        if
            playerOnQuestId == 0 and
            (hour >= 18 or hour < 1)
        then
            -- nobody is currently on the quest
            SetServerVariable('[JEUNO]CommService', player:getID())
            player:addQuest(xi.questLog.JEUNO, xi.quest.id.jeuno.COMMUNITY_SERVICE)
            player:setCharVar('currCommService', 1)
            player:updateEvent(1, doneCommService)
        else
            -- either another player or vasha have been assigned the quest
            player:updateEvent(0, doneCommService)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    -- COMMUNITY SERVICE
    if csid == 117 then
        local params = { title = xi.title.TORCHBEARER, var = 'currCommService' }
        if player:getQuestStatus(xi.questLog.JEUNO, xi.quest.id.jeuno.COMMUNITY_SERVICE) ~= xi.questStatus.QUEST_COMPLETED then
            -- first victory
            params.fame = 30
        else
            -- repeat victory. offer membership card.
            params.fame = 15
            if option == 1 then
                params.keyItem = xi.ki.LAMP_LIGHTERS_MEMBERSHIP_CARD
            end
        end

        npcUtil.completeQuest(player, xi.questLog.JEUNO, xi.quest.id.jeuno.COMMUNITY_SERVICE, params)

    elseif csid == 118 and option == 1 then
        -- player drops membership card
        player:delKeyItem(xi.ki.LAMP_LIGHTERS_MEMBERSHIP_CARD)

    elseif csid == 119 then
        -- player fails quest
        player:setCharVar('currCommService', 0)
    end
end

return entity
