-----------------------------------
-- Area: Castle Zvahl Keep (162)
--  Mob: Viscount Morax
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.CASTLE_ZVAHL_KEEP]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.VISCOUNT_MORAX - 2] = ID.mob.VISCOUNT_MORAX, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    xi.pet.setMobPet(mob, 1, 'Demons_Elemental')
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.HELLSBANE)
        xi.hunts.checkHunt(mob, player, 356)
    end
end

return entity
