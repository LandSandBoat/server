-----------------------------------
-- Area: Beadeaux [S]
--  Mob: Adaman Quadav
-- Note: PH for Ea'Tho Cruelheart and Ba'Tho Mercifulheart
-----------------------------------
local ID = zones[xi.zone.BEADEAUX_S]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.EATHO_CRUELHEART, 10, 7200) -- 2 hours
    xi.mob.phOnDespawn(mob, ID.mob.BATHO_MERCIFULHEART, 10, 7200) -- 2 hours
end

return entity
