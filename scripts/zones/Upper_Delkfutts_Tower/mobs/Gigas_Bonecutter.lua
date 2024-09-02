-----------------------------------
-- Area: Upper Delkfutt's Tower
--  Mob: Gigas Bonecutter
-- Note: PH for Enkelados
-----------------------------------
local ID = zones[xi.zone.UPPER_DELKFUTTS_TOWER]
-----------------------------------
---@type TMobEntity
local entity = {}

local enkeladosPHTable =
{
    [ID.mob.ENKELADOS[1] + 3] = ID.mob.ENKELADOS[1], -- -371.586 -144.367 28.244
    [ID.mob.ENKELADOS[2] + 3] = ID.mob.ENKELADOS[2], -- -215.194 -144.099 19.528
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 785, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, enkeladosPHTable, 5, 1) -- no cooldown
end

return entity
