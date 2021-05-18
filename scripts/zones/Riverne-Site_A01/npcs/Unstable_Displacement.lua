-----------------------------------
-- Area: Riverne Site #A01
--  NPC: Unstable Displacement
-- Note: entrance for "Ouryu Cometh"
-- !pos 183.390 -3.250 341.550 30
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_A01/IDs")
require("scripts/globals/bcnm")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SPACE_SEEMS_DISTORTED)
end

entity.onEventUpdate = function(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
