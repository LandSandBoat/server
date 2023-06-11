-----------------------------------
-- Area: Ilrusi Atoll (Extermination)
--  Mob: Carrion Toad
-----------------------------------
require("scripts/globals/assault")
local ID = require("scripts/zones/Ilrusi_Atoll/IDs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()
    local toadMob  = GetMobByID(ID.mob.UNDEAD_TOAD, instance)
    local randVal  = math.random(1, 5)

    if randVal == 1 and toadMob:getLocalVar("ToadSpawned") == 0 then
        SpawnMob(ID.mob.UNDEAD_TOAD, instance)
        toadMob:setLocalVar("ToadSpawned", 1)
    else
        xi.assault.progressInstance(mob, 1)
    end
end

return entity
