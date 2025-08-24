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
    [ID.mob.POISONHAND_GNADGAD - 10] = ID.mob.POISONHAND_GNADGAD, -- Orcish Impaler:     -53.910 -0.583 56.606
    [ID.mob.POISONHAND_GNADGAD - 9]  = ID.mob.POISONHAND_GNADGAD, -- Orcish Beastrider:  -62.647 -0.468 24.442
    [ID.mob.POISONHAND_GNADGAD - 8]  = ID.mob.POISONHAND_GNADGAD, -- Orcish Nightraider: -64.578 -0.658 61.273
    [ID.mob.POISONHAND_GNADGAD - 7]  = ID.mob.POISONHAND_GNADGAD, -- Orcish Brawler:     -59.013 -0.590 14.783
    [ID.mob.POISONHAND_GNADGAD - 6]  = ID.mob.POISONHAND_GNADGAD, -- Orcish Impaler:     -50.158 -0.537 22.257
    [ID.mob.POISONHAND_GNADGAD - 5]  = ID.mob.POISONHAND_GNADGAD, -- Orcish Beastrider:  -56.626 -0.607 63.285
    [ID.mob.POISONHAND_GNADGAD - 4]  = ID.mob.POISONHAND_GNADGAD, -- Orcish Nightraider: -54.694 -0.545 42.385
    [ID.mob.POISONHAND_GNADGAD - 3]  = ID.mob.POISONHAND_GNADGAD, -- Orcish Firebelcher: -60.057 -0.655 29.127
}

entity.spawnPoints =
{
    { x = -61.045, y = -0.517, z = 41.996 },
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 195)
end

return entity
