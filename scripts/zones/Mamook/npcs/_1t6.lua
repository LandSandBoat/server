-----------------------------------
-- Area: Mamook
--  NPC: _1t6 (Ebony Door)
-- Notes: Locked Door.  Opened via Tanscale Key or Thief picking the lock.  Openable from inside the door.
-- !pos 100.000, 12.943, -440.000
-----------------------------------
local mamookGlobal = require('scripts/zones/Mamook/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    mamookGlobal.onTradeEbonyDoor(player, npc, trade, player:getZPos() < -440.000)
end

entity.onTrigger = function(player, npc)
    mamookGlobal.onTriggerEbonyDoor(player, npc, player:getZPos() < -440.000)
end

return entity
