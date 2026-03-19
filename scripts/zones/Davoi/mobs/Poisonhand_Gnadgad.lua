-----------------------------------
-- Area: Davoi
--   NM: Poisonhand Gnadgad
-----------------------------------
local ID = zones[xi.zone.DAVOI]
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.POISONHAND_GNADGAD - 21]  = ID.mob.POISONHAND_GNADGAD, -- Orcish Beastrider:  Confirmed on retail
    [ID.mob.POISONHAND_GNADGAD - 20]  = ID.mob.POISONHAND_GNADGAD, -- Orcish Nightraider: Confirmed on retail
    [ID.mob.POISONHAND_GNADGAD - 6]  = ID.mob.POISONHAND_GNADGAD,  -- Orcish Impaler:     Confirmed on retail
}

entity.spawnPoints =
{
    { x = -61.045, y = -0.517, z = 41.996 },
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 195)
end

return entity
