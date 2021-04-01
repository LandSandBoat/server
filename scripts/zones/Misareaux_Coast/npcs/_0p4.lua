-----------------------------------
-- Area: Misareaux Coast
--  NPC: Storage Compartment
--  COP spawn Boggelmann.
-----------------------------------
local ID = require("scripts/zones/Misareaux_Coast/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local cop = player:getCurrentMission(COP)

    if (cop == xi.mission.id.cop.CALM_BEFORE_THE_STORM and not GetMobByID(ID.mob.BOGGELMANN):isSpawned() and player:getCharVar("COP_Boggelmann_KILL") == 0) then
        SpawnMob(ID.mob.BOGGELMANN):updateClaim(player)
    elseif (cop == xi.mission.id.cop.CALM_BEFORE_THE_STORM and player:getCharVar("COP_Boggelmann_KILL") == 1) then
        player:startEvent(13)
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 13) then
        player:setCharVar("COP_Boggelmann_KILL", 2)
        npcUtil.giveKeyItem(player, xi.ki.VESSEL_OF_LIGHT_KI)
    end
end

return entity
