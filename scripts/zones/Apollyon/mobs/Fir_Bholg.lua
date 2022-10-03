-----------------------------------
-- Area: Apollyon SW, Floor 1
--  Mob: Fir Bholg
-----------------------------------
require("scripts/zones/Apollyon/bcnms/sw_apollyon_helper")
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.apollyon_sw.handleMobDeathFloorOne(mob, player, optParams)
end

return entity
