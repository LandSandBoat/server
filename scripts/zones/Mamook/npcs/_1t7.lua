-----------------------------------
-- Area: Mamook
--  NPC: _1t7 (Ebony Door)
-- Notes: Locked Door.  Opened via Tanscale Key or Thief picking the lock.  Openable from inside the door.
-- !pos 400.000, 40.937, 420.000
-----------------------------------
local mamookGlobal = require('scripts/zones/Mamook/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    mamookGlobal.onTradeEbonyDoor(player, npc, trade, player:getXPos() > 400.000)
end

entity.onTrigger = function(player, npc)
    mamookGlobal.onTriggerEbonyDoor(player, npc, player:getXPos() > 400.000)
end

return entity
