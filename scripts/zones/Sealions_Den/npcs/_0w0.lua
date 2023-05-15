-----------------------------------
-- Area: Sealion's Den
--  NPC: Iron Gate
-- !pos 612 132 774 32
-----------------------------------
require("scripts/globals/bcnm")
local ID = require("scripts/zones/Sealions_Den/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.bcnm.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.ONE_TO_BE_FEARED or
        player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.THE_WARRIORS_PATH or
        player:hasStatusEffect(xi.effect.BATTLEFIELD)
    then
        xi.bcnm.onTrigger(player, npc)
    else
        player:messageSpecial(ID.text.IRON_GATE_LOCKED)
    end
end

entity.onEventUpdate = function(player, csid, option, extras)
    xi.bcnm.onEventUpdate(player, csid, option, extras)
end

entity.onEventFinish = function(player, csid, option)
    xi.bcnm.onEventFinish(player, csid, option)
end

return entity
