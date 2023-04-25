-----------------------------------
-- Area: Ilrusi Atoll (Extermination)
--  Mob: Carrion Crab
-----------------------------------
require("scripts/globals/assault")
local ID = require("scripts/zones/Ilrusi_Atoll/IDs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()
    local crabMob  = GetMobByID(ID.mob.UNDEAD_CRAB, instance)
    local randVal  = math.random(1, 5)

    if randVal == 1 and crabMob:getLocalVar("CrabSpawned") == 0 then
        SpawnMob(ID.mob.UNDEAD_CRAB, instance)
        crabMob:setLocalVar("CrabSpawned", 1)
    else
        xi.assault.progressInstance(mob, 1)
    end
end

return entity
