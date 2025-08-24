-----------------------------------
-- Area: Ifrit's Cauldron
--  Mob: Eotyrannus
-- Note: PH for Lindwurm
-----------------------------------
local ID = zones[xi.zone.IFRITS_CAULDRON]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 758, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.LINDWURM, 5, 3600) -- 1 hour
end

return entity
