-----------------------------------
-- Area: Alzadaal Undersea Ruins
--   NM: Alexander
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  620.000, y = -0.449, z = -260.000 },
    { x = -580.000, y = -0.449, z = -100.000 },
    { x = -580.000, y = -0.449, z = -460.000 }, -- TODO: one more spawn position remains uncaptured
}

entity.onMobInitialize = function(mob)
    xi.events.strangeHappenings.onMobInitialize(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    xi.mob.updateNMSpawnPoint(mob)

    if xi.settings.main.ENABLE_STRANGE_HAPPENINGS ~= 1 then
        DisallowRespawn(mob:getID(), true)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.events.strangeHappenings.onMobDeath(mob)
end

entity.onMobDespawn = function(mob)
    xi.mob.updateNMSpawnPoint(mob)
end

return entity
