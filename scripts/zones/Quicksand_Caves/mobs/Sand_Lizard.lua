-----------------------------------
-- Area: Quicksand Caves
--  Mob: Sand Lizard
-- Note: PH for Nussknacker
-----------------------------------
local ID = zones[xi.zone.QUICKSAND_CAVES]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 817, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    local zone = mob:getZone()
    if not zone then
        return
    end

    -- TODO: Need to check if it can pop if the PH was killed BEFORE the sandstorm appeared
    if zone:getWeather() == xi.weather.SAND_STORM then
        xi.mob.phOnDespawn(mob, ID.mob.NUSSKNACKER, 20, 3600) -- 1 hour
    end
end

return entity
