-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Fiaudie
-- !pos -10 1 35 80
-- Explains Campaign Ops, freelances
-- Trigger event 313 for ENDLESS DEBUG HELL
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local allegiance =  player:getCampaignAllegiance()
    local rank = xi.campaign.getMedalRank(player)

    player:startEvent(312, allegiance, rank, 0, 0, 0, 0, 0)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
