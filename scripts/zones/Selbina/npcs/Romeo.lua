-----------------------------------
-- Area: Selbina
--  NPC: Romeo
-- Starts and Finishes Quest: Donate to Recycling
-- !pos -11 -11 -6 248
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.DONATE_TO_RECYCLING) == xi.questStatus.QUEST_ACCEPTED and
        (
            npcUtil.tradeHas(trade, { { xi.item.ONION_DAGGER, 5 } }) or
            npcUtil.tradeHas(trade, { { xi.item.ONION_KNIFE, 5 } }) or
            npcUtil.tradeHas(trade, { { xi.item.ONION_SWORD, 5 } }) or
            npcUtil.tradeHas(trade, { { xi.item.ONION_ROD, 5 } }) or
            npcUtil.tradeHas(trade, { { xi.item.ONION_STAFF, 5 } })
        )
    then
        player:startEvent(21) -- Finish quest "Donate to Recycling"
    end
end

entity.onTrigger = function(player, npc)
    local donateToRecycling = player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.DONATE_TO_RECYCLING)

    if donateToRecycling == xi.questStatus.QUEST_AVAILABLE then
        player:startEvent(20) -- Start quest "Donate to Recycling"
    elseif donateToRecycling == xi.questStatus.QUEST_ACCEPTED then
        player:startEvent(22) -- During quest "Donate to Recycling"
    else
        player:startEvent(23) -- Standard dialog
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 20 then
        player:addQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.DONATE_TO_RECYCLING)
    elseif
        csid == 21 and
        npcUtil.completeQuest(player, xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.DONATE_TO_RECYCLING, { item = xi.item.WASTEBASKET, fame_area = xi.fameArea.SELBINA_RABAO, title = xi.title.ECOLOGIST })
    then
        player:confirmTrade()
    end
end

return entity
