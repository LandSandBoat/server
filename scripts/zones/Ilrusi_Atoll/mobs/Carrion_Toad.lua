-----------------------------------
-- Area: Ilrusi Atoll (Extermination)
--  Mob: Carrion Toad
-----------------------------------
local ID = require("scripts/zones/Ilrusi_Atoll/IDs")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    local instance = mob:getInstance()
    local TOAD = GetMobByID(ID.mob.UNDEAD_TOAD, instance)
    local RAND = math.random(1, 5)

    if RAND == 1 and TOAD:getLocalVar("ToadSpawned") == 0 then
        SpawnMob(ID.mob.UNDEAD_TOAD, instance)
        TOAD:setLocalVar("ToadSpawned", 1)
    else
        instance:setProgress(instance:getProgress() + 1)
    end
end

return entity
