-----------------------------------
-- Area: Ghelsba Outpost (140)
--   NM: Thousandarm Deshglesh
-----------------------------------
require("scripts/globals/hunts")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 170)
end

return entity
