-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Hantileon
-- Type: VCS Chocobo Trainer
-- !pos -2.675 -1.1 -105.287 230
-----------------------------------
require("scripts/globals/chocobo_raising")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.chocoboRaising.onTradeVCSTrainer(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.chocoboRaising.onTriggerVCSTrainer(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
    xi.chocoboRaising.onEventUpdateVCSTrainer(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.chocoboRaising.onEventFinishVCSTrainer(player, csid, option)
end

return entity
