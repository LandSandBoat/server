-----------------------------------
-- Area: Castle Oztroja (151)
--  Mob: Yagudo Theologist
-- Note: PH for Moo Ouzi the Swiftblade
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
---@type TMobEntity
local entity = {}

local mooQuziPHTable =
{
    [ID.mob.MOO_OUZI_THE_SWIFTBLADE - 7] = ID.mob.MOO_OUZI_THE_SWIFTBLADE, -- -18.415 -0.075 -92.889
    [ID.mob.MOO_OUZI_THE_SWIFTBLADE - 3] = ID.mob.MOO_OUZI_THE_SWIFTBLADE, -- -38.689 0.191 -101.068
}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, mooQuziPHTable, 5, 3600) -- 1 hour
end

return entity
