-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--  Mob: Mousse
-- Note: PH for Sewer Syrup
-----------------------------------
local ID = zones[xi.zone.BOSTAUNIEUX_OUBLIETTE]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.SEWER_SYRUP, 10, 7200) -- 2 hour minimum
end

return entity
