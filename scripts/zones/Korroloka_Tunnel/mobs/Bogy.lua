-----------------------------------
-- Area: Korroloka Tunnel (173)
--  Mob: Bogy
-- Note: PH for Dame Blanche
-----------------------------------
local ID = zones[xi.zone.KORROLOKA_TUNNEL]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 732, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.DAME_BLANCHE_PH, 5, 7200) -- 2 hour minimum
end

return entity
