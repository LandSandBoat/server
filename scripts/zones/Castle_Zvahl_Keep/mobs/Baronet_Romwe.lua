-----------------------------------
-- Area: Castle Zvahl Keep (162)
--  Mob: Baronet Romwe
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local ID = zones[xi.zone.CASTLE_ZVAHL_KEEP]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.BARONET_ROMWE - 1] = ID.mob.BARONET_ROMWE, -- Confirmed on retail
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
        xi.hunts.checkHunt(mob, player, 353)
    end
end

return entity
