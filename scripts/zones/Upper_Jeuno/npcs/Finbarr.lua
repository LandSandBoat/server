-----------------------------------
-- Area: Upper Jeuno
--  NPC: Finbarr
-- Type: VCS Honeymoon (chocobo breeding)
-- !pos -52.427 8.199 98.468 244
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.chocoboRaising.breeding.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.chocoboRaising.breeding.onTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.chocoboRaising.breeding.onEventFinish(player, csid, option, npc)
end

return entity
