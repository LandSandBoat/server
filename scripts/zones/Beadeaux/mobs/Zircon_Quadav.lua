-----------------------------------
-- Area: Beadeaux (147)
--  Mob: Zircon Quadav
-- Notes: PH for Zo'Khu Blackcloud
--  Bowl of Quadav Stew is a guaranteed steal with
--  Quest THE_TENSHODO_SHOWDOWN active
-----------------------------------
local ID = zones[xi.zone.BEADEAUX]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.ZO_KHU_BLACKCLOUD, 10, 3600) -- 1 hour
end

return entity
