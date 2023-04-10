-----------------------------------
-- Area: Central Temenos 2nd Floor
--  Mob: Mystic Avatar (Leviathan)
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        delay = math.random(45, 90),
        specials =
        {
            { id = 866, hpp = math.random(30, 55) }, -- uses Tidal Wave once while near 50% HPP.
        },
    })
end

return entity
