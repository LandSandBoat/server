-----------------------------------
-- Area: Valkurm Dunes (103)
--  Mob: Giant Bat
--  PH for Golden Bat
-----------------------------------
local ID = zones[xi.zone.VALKURM_DUNES]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local params = { }
    xi.mob.phOnDespawn(mob, ID.mob.GOLDEN_BAT, 5, 3600, params) -- 1 hour minimum
end

return entity
