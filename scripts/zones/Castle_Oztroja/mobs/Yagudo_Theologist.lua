-----------------------------------
-- Area: Castle Oztroja (151)
--  Mob: Yagudo Theologist
-- Note: PH for Moo Ouzi the Swiftblade
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.MOO_OUZI_THE_SWIFTBLADE, 5, 3600) -- 1 hour
end

return entity
