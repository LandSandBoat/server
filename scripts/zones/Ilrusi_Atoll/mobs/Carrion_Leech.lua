-----------------------------------
-- Area: Ilrusi Atoll (Extermination)
--  Mob: Carrion Leech
-----------------------------------
local ID = require("scripts/zones/Ilrusi_Atoll/IDs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    local LEECH = GetMobByID(ID.mob.UNDEAD_LEECH, instance)
    local RAND = math.random(1, 5)

    if RAND == 1 and LEECH:getLocalVar("LeechSpawned") == 0 then
        SpawnMob(ID.mob.UNDEAD_LEECH, instance)
        LEECH:setLocalVar("LeechSpawned", 1)
    else
        instance:setProgress(instance:getProgress() + 1)
    end
end

return entity
