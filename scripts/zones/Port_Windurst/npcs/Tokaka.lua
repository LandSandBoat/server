-----------------------------------
-- Area: Port Windurst
--  NPC: Tokaka
-- Starts & Finishes Repeatable Quest: Something Fishy
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local tokakaSpokenTo = player:getCharVar('TokakaSpokenTo')
    local needToZone     = player:needToZone()

    if tokakaSpokenTo == 1 and not needToZone then
        if
            trade:hasItemQty(xi.item.BASTORE_SARDINE, 1) and
            trade:getItemCount() == 1
        then
            player:startEvent(210, xi.settings.main.GIL_RATE * 70, xi.item.BASTORE_SARDINE)
        end
    end
end

entity.onTrigger = function(player, npc)
    local somethingFishy = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.SOMETHING_FISHY)

    if somethingFishy >= xi.questStatus.QUEST_ACCEPTED then
        if player:needToZone() then
            player:startEvent(211)
        else
            player:startEvent(209, 0, xi.item.BASTORE_SARDINE)
        end
    elseif somethingFishy == xi.questStatus.QUEST_AVAILABLE then
        player:startEvent(208, 0, xi.item.BASTORE_SARDINE)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 208 then
        player:addQuest(xi.questLog.WINDURST, xi.quest.id.windurst.SOMETHING_FISHY)
        player:setCharVar('TokakaSpokenTo', 1)
    elseif csid == 210 then
        local somethingFishy = player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.SOMETHING_FISHY)

        if somethingFishy == xi.questStatus.QUEST_ACCEPTED then
            player:completeQuest(xi.questLog.WINDURST, xi.quest.id.windurst.SOMETHING_FISHY)
            player:addFame(xi.fameArea.WINDURST, 60)
        else
            player:addFame(xi.fameArea.WINDURST, 10)
        end

        player:tradeComplete()
        player:addGil(xi.settings.main.GIL_RATE * 70)
        player:setCharVar('TokakaSpokenTo', 0)
        player:needToZone(true)
    elseif csid == 209 then
        player:setCharVar('TokakaSpokenTo', 1)
    end
end

return entity
