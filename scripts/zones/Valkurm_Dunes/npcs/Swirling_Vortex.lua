-----------------------------------
-- Area: Valkurm Dunes
--  NPC: Swirling Vortex
-- Entrance to Lufaise Meadows
-- !pos 420.057 0.000 -199.905 103
-----------------------------------
require("scripts/globals/teleports")
require("scripts/globals/missions")
local ID = require("scripts/zones/Valkurm_Dunes/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)

    if (player:hasCompletedMission(tpz.mission.log_id.COP, tpz.mission.id.cop.THE_MOTHERCRYSTALS)) then
        player:startEvent(12)
    else
        player:messageSpecial(ID.text.AN_EMPTY_LIGHT_SWIRLS)
    end

end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)

    if (csid == 12 and option == 1) then
        tpz.teleport.to(player, tpz.teleport.id.LUFAISE_VORTEX)
    end

end

return entity
