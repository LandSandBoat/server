-----------------------------------
-- Area: Mamook
--  NPC: _1t4 (Ebony Door)
-- Notes: Locked Door.  Opened via Tanscale Key or Thief picking the lock.  Openable from inside the door.
-- !pos 140.000, 3.931, -360.000
-----------------------------------
local mamookGlobal = require('scripts/zones/Mamook/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    mamookGlobal.onTradeEbonyDoor(player, npc, trade, player:getZPos() > -360.000)
end

entity.onTrigger = function(player, npc)
    mamookGlobal.onTriggerEbonyDoor(player, npc, player:getZPos() > -360.000)
end

return entity
