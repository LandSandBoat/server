-----------------------------------
-- Area: Aydeewa Subterrane
--  Mob: Qiqirn Archaeologist
-- Note: PH for Bluestreak Gyugyuroon
-----------------------------------
local ID = require("scripts/zones/Aydeewa_Subterrane/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.BLUESTREAK_GYUGYUROON_PH, 10, 7200) -- 2 hours
end

return entity
