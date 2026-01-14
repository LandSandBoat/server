-----------------------------------
-- Area: Konschtat Highlands
--   NM: Steelfleece Baldarich
-----------------------------------
local ID = zones[xi.zone.KONSCHTAT_HIGHLANDS]
mixins =
{
    require('scripts/mixins/job_special'),
    require('scripts/mixins/draw_in'),
}
require('scripts/quests/tutorial')
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.RAMPAGING_RAM] = ID.mob.STEELFLEECE, -- 160 24 121
}

entity.spawnPoints =
{
    { x = -10.000, y = 7.000, z = 45.000 },
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 5)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.MIGHTY_STRIKES, hpp = math.random(95, 100), cooldown = 60 } -- "Uses ... Mighty Strikes, which can be used multiple times."
        }
    })
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.THE_HORNSPLITTER)
    xi.tutorial.onMobDeath(player)
end

return entity
