-----------------------------------
-- Area: West Ronfaure
--  Mob: Marauder Dvogzog
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/missions")
require("scripts/globals/regimes")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobDeath(mob, player, isKiller)
    if player:getCurrentMission(SANDORIA) == tpz.mission.id.sandoria.PRESTIGE_OF_THE_PAPSQUE and player:getCharVar("MissionStatus") == 1 then
        player:setCharVar("Mission7-1MobKilled", 1)
        player:needToZone(true)
    end
    tpz.regime.checkRegime(player, mob, 4, 1, tpz.regime.type.FIELDS)
end

return entity
