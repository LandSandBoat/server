-----------------------------------
-- Area: La Theine Plateau
--   NM: Bloodtear Baldurf
-----------------------------------
mixins =
{
    require('scripts/mixins/job_special'),
    require('scripts/mixins/draw_in'),
}
require('scripts/quests/tutorial')
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.MIGHTY_STRIKES, hpp = math.random(90, 95), cooldown = 120 } -- "Special Attacks: ... Mighty Strikes (multiple times)"
        }
    })
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.THE_HORNSPLITTER)
    xi.tutorial.onMobDeath(player)
end

return entity
