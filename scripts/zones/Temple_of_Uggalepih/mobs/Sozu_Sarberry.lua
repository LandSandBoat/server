-----------------------------------
-- Area: Temple of Uggalepih
--   NM: Sozu Sarberry
-----------------------------------
mixins =
{
    require('scripts/mixins/families/tonberry'),
    require('scripts/mixins/job_special')
}
-----------------------------------
local ID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.SOZU_SARBERRY - 3] = ID.mob.SOZU_SARBERRY, -- Confirmed on retail
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 3000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 3000)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.mobSkill.MIJIN_GAKURE_1, hpp = math.randomInt(20, 30) },
        },
    })

    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 388)
end

return entity
