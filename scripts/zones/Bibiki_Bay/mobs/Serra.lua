-----------------------------------
-- Area: Bibiki Bay
--   NM: Serra
-----------------------------------
local ID = zones[xi.zone.BIBIKI_BAY]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.SERRA - 1] = ID.mob.SERRA,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.magian.onMobDeath(mob, player, optParams, set{ 4 })
    xi.hunts.checkHunt(mob, player, 264)
end

return entity
