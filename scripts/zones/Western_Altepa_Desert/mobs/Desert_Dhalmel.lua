-----------------------------------
-- Area: Western Altepa Desert
--  Mob: Desert Dhalmel
-- Note: Place holder for Celphie
-----------------------------------
local ID = zones[xi.zone.WESTERN_ALTEPA_DESERT]
-----------------------------------
---@type TMobEntity
local entity = {}

local celphiePHTable =
{
    [ID.mob.CELPHIE - 1] = ID.mob.CELPHIE, -- 50.014 0.256 7.088
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 135, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, celphiePHTable, 10, 7200) -- 2 hours
end

return entity
