-----------------------------------
-- Area: Windurst Woods
--  NPC: Ibwam
-- Type: Warp NPC
-- !pos -25.655 1.749 -60.651 241
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, { { 'gil', 300 } }) and
        player:getQuestStatus(xi.questLog.WINDURST, xi.quest.id.windurst.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_COMPLETED and
        player:getCurrentMission(xi.mission.log_id.TOAU) > xi.mission.id.toau.IMMORTAL_SENTRIES
    then
        -- Needs a check for at least traded an invitation card to Naja Salaheem
        player:startEvent(794)
    end
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(xi.mission.log_id.TOAU) >= xi.mission.id.toau.PRESIDENT_SALAHEEM then
        player:startEvent(793)
    else
        player:startEvent(740)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 794 then
        player:confirmTrade()
        xi.teleport.to(player, xi.teleport.id.WHITEGATE)
    end
end

return entity
