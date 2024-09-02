-----------------------------------
-- Area: Bostaunieux Oubliette (167)
--  Mob: Mousse
-- Note: PH for Sewer Syrup
-----------------------------------
local ID = zones[xi.zone.BOSTAUNIEUX_OUBLIETTE]
-----------------------------------
---@type TMobEntity
local entity = {}

local sewerSyrupPHTable =
{
    [ID.mob.SEWER_SYRUP - 2] = ID.mob.SEWER_SYRUP, -- -19.000 1.000 -173.000
    [ID.mob.SEWER_SYRUP - 1] = ID.mob.SEWER_SYRUP, -- -20.000 1.000 -148.000
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, sewerSyrupPHTable, 10, 7200) -- 2 hour minimum
end

return entity
