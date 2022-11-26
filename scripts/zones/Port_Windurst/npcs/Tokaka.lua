-----------------------------------
-- Area: Port Windurst
--  NPC: Tokaka
-- Starts & Finishes Repeatable Quest: Something Fishy
-----------------------------------
require("scripts/globals/quests")
require("scripts/globals/settings")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local tokakaSpokenTo = player:getCharVar("TokakaSpokenTo")
    local needToZone     = player:needToZone()

    if tokakaSpokenTo == 1 and not needToZone then
        if trade:hasItemQty(4360, 1) and trade:getItemCount() == 1 then
            player:startEvent(210, xi.settings.main.GIL_RATE * 70, 4360)
        end
    end
end

entity.onTrigger = function(player, npc)
    local somethingFishy = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.SOMETHING_FISHY)

    if somethingFishy >= QUEST_ACCEPTED then
        if player:needToZone() then
            player:startEvent(211)
        else
            player:startEvent(209, 0, 4360)
        end
    elseif somethingFishy == QUEST_AVAILABLE then
        player:startEvent(208, 0, 4360)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 208 then
        player:addQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.SOMETHING_FISHY)
        player:setCharVar("TokakaSpokenTo", 1)
    elseif csid == 210 then
        local somethingFishy = player:getQuestStatus(xi.quest.log_id.WINDURST, xi.quest.id.windurst.SOMETHING_FISHY)

        if somethingFishy == QUEST_ACCEPTED then
            player:completeQuest(xi.quest.log_id.WINDURST, xi.quest.id.windurst.SOMETHING_FISHY)
            player:addFame(xi.quest.fame_area.WINDURST, 60)
        else
            player:addFame(xi.quest.fame_area.WINDURST, 10)
        end

        player:tradeComplete()
        player:addGil(xi.settings.main.GIL_RATE * 70)
        player:setCharVar("TokakaSpokenTo", 0)
        player:needToZone(true)
    elseif csid == 209 then
        player:setCharVar("TokakaSpokenTo", 1)
    end
end

return entity
