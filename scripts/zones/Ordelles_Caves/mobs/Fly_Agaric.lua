-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Fly Agaric
-- Note: PH for Donggu
-----------------------------------
local ID = zones[xi.zone.ORDELLES_CAVES]
-----------------------------------
local entity = {}

local dongguPHTable =
{
    [ID.mob.DONGGU - 4] = ID.mob.DONGGU,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 656, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, dongguPHTable, 10, 1) -- Window opens immediately from its last Time of Death.
end

return entity
