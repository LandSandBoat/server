-----------------------------------
-- Area: Konschtat Highlands
--   NM: Haty
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
end

entity.onMobRoam = function(mob)
    local hour      = VanadielHour()
    local moonCycle = getVanadielMoonCycle()
    if
        (hour >= 5 and hour < 17) or
        (moonCycle ~= xi.moonCycle.FULL_MOON)
    then
        DespawnMob(mob:getID())
    end
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
    mob:setLocalVar('cooldown', GetSystemTime() + (144 * 13)) -- 13 vanadiel hours guarantees it will not spawn twice in the same night
end

return entity
