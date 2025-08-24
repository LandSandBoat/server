-----------------------------------
-- Area: Qufim Island
--   NM: Trickster Kinetix
-----------------------------------
local ID = zones[xi.zone.QUFIM_ISLAND]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.TRICKSTER_KINETIX - 4] = ID.mob.TRICKSTER_KINETIX, -- -138.180 -20.928 228.793
    [ID.mob.TRICKSTER_KINETIX - 3] = ID.mob.TRICKSTER_KINETIX, -- -157.659 -25.501 235.862
    [ID.mob.TRICKSTER_KINETIX - 2] = ID.mob.TRICKSTER_KINETIX, -- -152.269 -20 243
    [ID.mob.TRICKSTER_KINETIX - 1] = ID.mob.TRICKSTER_KINETIX, -- -137.651 -23.507 231.528
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 307)
end

return entity
