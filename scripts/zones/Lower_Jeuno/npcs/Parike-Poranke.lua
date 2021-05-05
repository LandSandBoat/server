-----------------------------------
-- Area: Lower Jeuno
--  NPC: Parike-Poranke
-- Type: Adventurer's Assistant
-- !pos -33.161 -1 -61.303 245
-----------------------------------
local ID = require("scripts/zones/Lower_Jeuno/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    player:messageSpecial(ID.text.PARIKE_PORANKE_DIALOG)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
