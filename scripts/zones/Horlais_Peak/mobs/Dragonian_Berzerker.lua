-----------------------------------
-- Area: Horlais Peak
--  Mob: Dragonian Berzerker
-- KSNM30
-- TODO: Chaos Blade effect gets stronger after they use their respective 2-hour.
--       50% HP/MP reduction pre-2 hour and 75% HP/MP reduction post-2 hour.
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    tpz.mix.jobSpecial.config(mob, {
        specials =
        {
            {
                id = tpz.jsa.MIGHTY_STRIKES,
                endCode = function(mob)
                    mob:addMod(tpz.mod.ATT, 200)
                end,
            },
        },
    })
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
