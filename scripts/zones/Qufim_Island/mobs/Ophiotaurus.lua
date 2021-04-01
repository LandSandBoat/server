-----------------------------------
-- Area: Qufim Island
--  MOB: Ophiotaurus
-----------------------------------
local ID = require("scripts/zones/Qufim_Island/IDs")
require("scripts/globals/missions")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 5)
end

entity.onMobDeath = function(mob, player, isKiller)
    local party = player:getParty()
    for _, member in pairs(party) do
        if member:getCurrentMission(ROV) == xi.mission.id.rov.THE_LIONS_ROAR then
            member:completeMission(xi.mission.log_id.ROV, xi.mission.id.rov.THE_LIONS_ROAR)
            member:addMission(xi.mission.log_id.ROV, xi.mission.id.rov.EDDIES_OF_DESPAIR_I)
        end
    end
end

return entity
