-----------------------------------
-- Area: Konschtat Highlands
--   NM: Steelfleece Baldarich
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/quests/tutorial")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.MIGHTY_STRIKES, hpp = math.random(90, 95), cooldown = 120 } -- "Uses ... Mighty Strikes, which can be used multiple times."
        }
    })
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.THE_HORNSPLITTER)
    xi.tutorial.onMobDeath(player)
end

return entity
