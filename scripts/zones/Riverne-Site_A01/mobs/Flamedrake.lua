-----------------------------------
-- Area: Riverne - Site A01
--  Mob: Flamedrake PH
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_A01/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.mobOnDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.AIATAR_PH, 10, 75600) -- 50 minutes
end

return entity
