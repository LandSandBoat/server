-----------------------------------
-- Area: Batallia Downs (105)
--  Mob: Ahtu
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.nmTODPersist(mob, math.random(7200, 14400)) -- 2 to 4 hours
end

return entity
