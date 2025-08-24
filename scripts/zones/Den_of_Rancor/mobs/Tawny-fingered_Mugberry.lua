-----------------------------------
-- Area: Den of Rancor
--   NM: Tawny-fingered Mugberry
-----------------------------------
mixins =
{
    require('scripts/mixins/families/tonberry'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.DEN_OF_RANCOR]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.TAWNY_FINGERED_MUGBERRY - 14] = ID.mob.TAWNY_FINGERED_MUGBERRY,
    [ID.mob.TAWNY_FINGERED_MUGBERRY - 13] = ID.mob.TAWNY_FINGERED_MUGBERRY,
    [ID.mob.TAWNY_FINGERED_MUGBERRY - 11] = ID.mob.TAWNY_FINGERED_MUGBERRY,
    [ID.mob.TAWNY_FINGERED_MUGBERRY - 10] = ID.mob.TAWNY_FINGERED_MUGBERRY,
    [ID.mob.TAWNY_FINGERED_MUGBERRY - 5]  = ID.mob.TAWNY_FINGERED_MUGBERRY,
    [ID.mob.TAWNY_FINGERED_MUGBERRY - 4]  = ID.mob.TAWNY_FINGERED_MUGBERRY,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 396)
end

return entity
