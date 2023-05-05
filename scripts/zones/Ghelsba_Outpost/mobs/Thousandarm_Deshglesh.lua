-----------------------------------
-- Area: Ghelsba Outpost (140)
--   NM: Thousandarm Deshglesh
-----------------------------------
require("scripts/globals/hunts")
mixins = { require("scripts/mixins/job_special") }
require("scripts/globals/roe")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 170)
    xi.roe.onRecordTrigger(player, 220)
end

return entity
