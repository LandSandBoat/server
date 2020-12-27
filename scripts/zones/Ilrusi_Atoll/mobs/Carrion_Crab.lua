-----------------------------------
-- Area: Ilrusi Atoll (Extermination)
--  Mob: Carrion Crab
-----------------------------------
local ID = require("scripts/zones/Ilrusi_Atoll/IDs")
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    local CRAB = GetMobByID(ID.mob.UNDEAD_CRAB, instance)
    local RAND = math.random(1, 5)

    if RAND == 1 and CRAB:getLocalVar("CrabSpawned") == 0 then
        SpawnMob(ID.mob.UNDEAD_CRAB, instance)
        CRAB:setLocalVar("CrabSpawned", 1)
    else
        instance:setProgress(instance:getProgress() + 1)
    end
end
