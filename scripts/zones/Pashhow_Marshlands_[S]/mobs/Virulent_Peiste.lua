-----------------------------------
-- Area: Pashhow Marshlands [S]
--  Mob: Virulent Peiste
-- Note: PH for Sugaar
-----------------------------------
local ID = zones[xi.zone.PASHHOW_MARSHLANDS_S]
-----------------------------------
mixins = { require('scripts/mixins/families/peiste') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.SUGAAR, 5, 3600) -- 1 hour
end

return entity
