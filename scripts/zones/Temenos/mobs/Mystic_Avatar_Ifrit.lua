-----------------------------------
-- Area: Central Temenos 2nd Floor
--  Mob: Mystic Avatar (Ifrit)
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        delay = math.random(45, 90),
        specials =
        {
            { id = 848, hpp = math.random(30, 55) }, -- uses Inferno once while near 50% HPP.
        },
    })
end

return entity
