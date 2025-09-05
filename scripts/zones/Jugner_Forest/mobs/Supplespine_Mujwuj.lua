-----------------------------------
-- Area: Jugner Forest
--   NM: Supplespine Mujwuj
-----------------------------------
local ID = zones[xi.zone.JUGNER_FOREST]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  50.114, y = -0.184, z = -240.493 }
}

entity.phList =
{
    [ID.mob.SUPPLESPINE_MUJWUJ - 38] = ID.mob.SUPPLESPINE_MUJWUJ,
}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 100)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 160)
end

return entity
