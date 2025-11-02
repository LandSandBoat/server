-----------------------------------
-- Area: Konschtat Highlands
--   NM: Haty
-----------------------------------
require('scripts/quests/tutorial')
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobRoam = function(mob)
    local hour = VanadielHour()
    local phase = VanadielMoonPhase()
    if
        (hour >= 5 and hour < 17) or
        phase < 90
    then
        DespawnMob(mob:getID())
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setLocalVar('cooldown', GetSystemTime() + (144 * 13)) -- 13 vanadiel hours guarantees it will not spawn twice in the same night
end

return entity
