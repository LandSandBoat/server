-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Ferchinne
-- Note: Involved in quest: "Fly High"
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    local flyHigh = player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.FLY_HIGH)

    if
        flyHigh == QUEST_ACCEPTED and
        npcUtil.tradeHas(trade, { { xi.item.HIPPOGRYPH_TAILFEATHER, 2 } })
    then
        -- 2x Hippogryph Tailfeather
        player:startEvent(243)
    elseif
        flyHigh == QUEST_COMPLETED and
        npcUtil.tradeHas(trade, { { xi.item.HIPPOGRYPH_TAILFEATHER, 2 } })
    then
        -- 2x Hippogryph Tailfeather
        player:startEvent(245)
    end
end

entity.onTrigger = function(player, npc)
    if
        player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.THE_SAVAGE or
        player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.THE_SAVAGE)
    then
        local flyHigh = player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.FLY_HIGH)

        if flyHigh == QUEST_AVAILABLE then
            player:startEvent(241)
        elseif flyHigh == QUEST_ACCEPTED then
            player:startEvent(242)
        elseif flyHigh == QUEST_COMPLETED then
            player:startEvent(244)
        end
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 241 then
        player:addQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.FLY_HIGH)
    elseif
        csid == 243 and
        npcUtil.completeQuest(player, xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.FLY_HIGH, { item = xi.item.MISTMELT })
    then
        -- Mistmelt
        player:confirmTrade()
    elseif csid == 245 and npcUtil.giveItem(player, xi.item.MISTMELT) then -- Mistmelt
        player:confirmTrade()
    end
end

return entity
