-----------------------------------
-- Area: Windurst Waters
--  NPC: Jatan-Paratan
-- Starts and Finished Quest: Wondering Minstrel
-- !pos -59 -4 22 238
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local wonderingstatus = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.WONDERING_MINSTREL)
    if
        wonderingstatus == 1 and
        trade:hasItemQty(xi.item.PIECE_OF_ROSEWOOD_LUMBER, 1) and
        trade:getItemCount() == 1 and
        player:getCharVar('QuestWonderingMin_var') == 1
    then
        player:startEvent(638)                 -- WONDERING_MINSTREL: Quest Finish
    end
end

entity.onTrigger = function(player, npc)
    -- player:delQuest(xi.questLog.WINDURST, xi.quest.id.windurst.WONDERING_MINSTREL)
    local wonderingstatus = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.WONDERING_MINSTREL)
    local fame = player:getFameLevel(xi.fameArea.WINDURST)
    if wonderingstatus == xi.questStatus.QUEST_AVAILABLE and fame >= 5 then
        local rand = math.random(1, 2)
        if rand == 1 then
            player:startEvent(633)          -- WONDERING_MINSTREL: Before Quest
        else
            player:startEvent(634)          -- WONDERING_MINSTREL: Quest Start
        end
    elseif wonderingstatus == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(635)                 -- WONDERING_MINSTREL: During Quest
    elseif
        wonderingstatus == xi.questStatus.QUEST_COMPLETED and
        player:needToZone()
    then
        player:startEvent(639)                 -- WONDERING_MINSTREL: After Quest
    else
        local hour = VanadielHour()
        if hour >= 18 or hour <= 6 then
            player:startEvent(611)             -- Singing 1 (daytime < 6 or daytime >= 18)
        else
            local rand = math.random(1, 2)
            if rand == 1 then
                player:startEvent(610)          -- Standard Conversation 1 (daytime)
            else
                player:startEvent(615)             -- Standard Conversation 2 (daytime)
            end
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 634 then    -- WONDERING_MINSTREL: Quest Start
        player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.WONDERING_MINSTREL)
    elseif csid == 638 then  -- WONDERING_MINSTREL: Quest Finish
        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, xi.item.FAERIE_PICCOLO)
        else
            player:tradeComplete()
            player:completeQuest(xi.questLog.WINDURST, xi.quest.id.windurst.WONDERING_MINSTREL)
            player:addItem(xi.item.FAERIE_PICCOLO)
            player:messageSpecial(ID.text.ITEM_OBTAINED, xi.item.FAERIE_PICCOLO)
            player:addFame(xi.fameArea.WINDURST, 75)
            player:addTitle(xi.title.DOWN_PIPER_PIPE_UPPERER)
            player:needToZone(true)
            player:setCharVar('QuestWonderingMin_var', 0)
        end
    end
end

return entity
