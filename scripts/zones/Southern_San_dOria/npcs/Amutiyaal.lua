-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Amutiyaal
--  Warp NPC (Aht Urhgan)
-- !pos 116 0.1 84 230
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        trade:getGil() == 300 and
        trade:getItemCount() == 1 and
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_COMPLETED and
        player:getCurrentMission(xi.mission.log_id.TOAU) > xi.mission.id.toau.IMMORTAL_SENTRIES
    then
        -- Needs a check for at least traded an invitation card to Naja Salaheem
        player:startEvent(881)
    end
end

entity.onTrigger = function(player, npc)
    if player:getCurrentMission(xi.mission.log_id.TOAU) >= xi.mission.id.toau.PRESIDENT_SALAHEEM then
        player:startEvent(880)
    else
        player:startEvent(816)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 881 then
        player:tradeComplete()
        xi.teleport.to(player, xi.teleport.id.WHITEGATE)
    end
end

return entity
