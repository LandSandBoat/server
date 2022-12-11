-----------------------------------
-- Area: Temenos Eastern Tower
--  Mob: Mystic Avatar (Garuda)
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        delay = math.random(45, 90),
        specials =
        {
            { id = 875, hpp = math.random(30, 55) }, -- uses Aerial Blast once while near 50% HPP.
        },
    })
end

return entity
