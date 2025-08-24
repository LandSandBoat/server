-----------------------------------
-- Area: Beadeaux (254)
--  Mob: Brass Quadav
-- Note: PH for Bi'Gho Headtaker
-----------------------------------
local ID = zones[xi.zone.BEADEAUX]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.BI_GHO_HEADTAKER, 10, math.random(3600, 10800)) -- 1 to 3 hours
end

return entity
