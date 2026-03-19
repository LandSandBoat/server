-----------------------------------
-- Area: Castle Zvahl Keep (162)
--  Mob: Baron Vapula
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.CASTLE_ZVAHL_KEEP]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.BARON_VAPULA - 1] = ID.mob.BARON_VAPULA, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.HELLSBANE)
        xi.hunts.checkHunt(mob, player, 354)
    end
end

return entity
