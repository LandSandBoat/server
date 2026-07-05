-----------------------------------
-- Area: FeiYin
--  Mob: Clockwork Pod
-- Note: PH for Mind Hoarder
-----------------------------------
local ID = zones[xi.zone.FEIYIN]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.MIND_HOARDER, 10, math.randomInt(5400, 32400)) -- 1.5 to 9 hours
end

return entity
