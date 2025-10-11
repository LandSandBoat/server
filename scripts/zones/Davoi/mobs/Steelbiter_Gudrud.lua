-----------------------------------
-- Area: Davoi
--   NM: Steelbiter Gudrud
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.DAVOI]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.spawnPoints =
{
    { x =  244.000, y =  4.000, z = -240.000 }
}

entity.phList =
{
    [ID.mob.STEELBITER_GUDRUD - 7] = ID.mob.STEELBITER_GUDRUD, -- 252.457 3.501 -248.655
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Orcs_Wyvern')
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 194)
end

return entity
