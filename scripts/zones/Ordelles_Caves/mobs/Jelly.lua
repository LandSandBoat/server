-----------------------------------
-- Area: Ordelle's Caves
--  Mob: Jelly
-- Note: PH for Agar Agar
-----------------------------------
local ID = zones[xi.zone.ORDELLES_CAVES]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 659, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.AGAR_AGAR, 5, 3600) -- 1 hour
end

return entity
