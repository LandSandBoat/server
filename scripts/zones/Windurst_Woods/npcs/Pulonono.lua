-----------------------------------
-- Area: Windurst Woods
--  NPC: Pulonono
-- Type: VCS Chocobo Trainer
-- !pos 130.124 -6.35 -119.341 241
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.chocoboRaising.onTradeVCSTrainer(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.chocoboRaising.onTriggerVCSTrainer(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.chocoboRaising.onEventUpdateVCSTrainer(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.chocoboRaising.onEventFinishVCSTrainer(player, csid, option, npc)
end

return entity
