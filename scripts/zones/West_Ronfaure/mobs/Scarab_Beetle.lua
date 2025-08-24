-----------------------------------
-- Area: West Ronfaure(100)
--  Mob: Scarab Beetle
-- Note: Place holder for Fungus Beetle
-----------------------------------
local ID = zones[xi.zone.WEST_RONFAURE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 3, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 4, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    local params = { }
    xi.mob.phOnDespawn(mob, ID.mob.FUNGUS_BEETLE, 10, 900, params) -- 15 minute minimum
end

return entity
