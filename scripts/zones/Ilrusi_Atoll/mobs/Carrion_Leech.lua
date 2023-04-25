-----------------------------------
-- Area: Ilrusi Atoll (Extermination)
--  Mob: Carrion Leech
-----------------------------------
require("scripts/globals/assault")
local ID = require("scripts/zones/Ilrusi_Atoll/IDs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()
    local leechMob = GetMobByID(ID.mob.UNDEAD_LEECH, instance)
    local randVal  = math.random(1, 5)

    if randVal == 1 and leechMob:getLocalVar("LeechSpawned") == 0 then
        SpawnMob(ID.mob.UNDEAD_LEECH, instance)
        leechMob:setLocalVar("LeechSpawned", 1)
    else
        xi.assault.progressInstance(mob, 1)
    end
end

return entity
