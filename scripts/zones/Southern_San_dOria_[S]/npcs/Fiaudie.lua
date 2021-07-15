-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Fiaudie
-- !pos -10 1 35 80
-- Explains Campaign Ops, freelances
-- Trigger event 313 for ENDLESS DEBUG HELL
-----------------------------------
require("scripts/globals/campaign")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local allegiance =  player:getCampaignAllegiance()
    local rank = getMedalRank(player)

    player:startEvent(312, allegiance, rank, 0, 0, 0, 0, 0)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
