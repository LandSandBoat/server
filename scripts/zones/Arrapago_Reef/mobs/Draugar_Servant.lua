-----------------------------------
-- Area: Arrapago Reef
--  Mob: Draugar Servant
-- Note: PH for Bloody Bones
-----------------------------------
local ID = require("scripts/zones/Arrapago_Reef/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.BLOODY_BONES_PH, 5, 75600) -- 21 hours
end

return entity
