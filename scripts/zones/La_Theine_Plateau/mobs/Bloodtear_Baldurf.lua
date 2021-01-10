-----------------------------------
-- Area: La Theine Plateau
--   NM: Bloodtear Baldurf
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/quests/tutorial")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.ALWAYS_AGGRO, 1)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
end

function onMobSpawn(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {id = tpz.jsa.MIGHTY_STRIKES, hpp = math.random(90, 95), cooldown = 120} -- "Special Attacks: ... Mighty Strikes (multiple times)"
        }
    })
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.THE_HORNSPLITTER)
    tpz.tutorial.onMobDeath(player)
end

return entity
