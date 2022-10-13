-----------------------------------
-- Area: Phanauet Channel
--  NPC: Riche
-- Type: Standard NPC
-- !pos 5.945 -3.75 13.612 1
-----------------------------------
local ID = require("scripts/zones/Phanauet_Channel/IDs")
require("scripts/globals/barge")
-----------------------------------

local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.RICHE_MESSAGE) -- Ticket Count -1 Message
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
