-----------------------------------
-- Area: Temenos Eastern Tower
--  Mob: Mystic Avatar (Fenrir)
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        delay = math.random(45, 90),
        specials =
        {
            { id = 838, hpp = math.random(15, 55) }, -- uses Howling Moon once while near 50% HPP.
        },
    })
end

return entity
