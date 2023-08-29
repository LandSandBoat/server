-----------------------------------
-- Area: Bastok Markets
--  NPC: Ardea
-- !pos -198 -6 -69 235
-- Involved in quests: Chasing Quotas, Rock Racketeer
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local chasingQuotasStatus = player:getCharVar("ChasingQuotas_Progress")

    if chasingQuotasStatus == 3 then
        player:startEvent(264) -- Someone was just asking about that earring.
    elseif chasingQuotasStatus == 4 then
        player:startEvent(265) -- They'll be happy if you return it.
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 264 then
        player:setCharVar("ChasingQuotas_Progress", 4)
    end
end

return entity
