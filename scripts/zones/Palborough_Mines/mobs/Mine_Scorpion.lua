-----------------------------------
-- Area: Palborough Mines
--  Mob: Mine Scorpion
-- Note: PH for Scimitar Scorpion
-----------------------------------
local ID = require("scripts/zones/Palborough_Mines/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    if mob:getID() == ID.mob.SCIMITAR_SCORPION_PH then
        mob:setRespawnTime(xi.mob.respawnTimer.DUNGEON)
    end
    xi.mob.phOnDespawn(mob, ID.mob.SCIMITAR_SCORPION_PH, 10, 1) -- No cooldown
end

return entity
