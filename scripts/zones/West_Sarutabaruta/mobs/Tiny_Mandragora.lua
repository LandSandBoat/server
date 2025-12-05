-----------------------------------
-- Area: West Sarutabaruta
--  Mob: Tiny Mandragora
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    -- Set respawn time in **seconds**
    mob:setRespawnTime(30)  -- 30 seconds on respawn.
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 26, 1, xi.regime.type.FIELDS)
end

return entity
