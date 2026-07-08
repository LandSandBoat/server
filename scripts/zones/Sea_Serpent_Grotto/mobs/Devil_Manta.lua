-----------------------------------
-- Area: Sea Serpent Grotto (176)
--  Mob: Devil Manta
-- Note: Place holder Charybdis
-----------------------------------
local ID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 810, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    -- TODO: Confirm it actually opens after 8 hours
    xi.mob.phOnDespawn(mob, ID.mob.CHARYBDIS, 10, 28800) -- 8 hour open
end

return entity
