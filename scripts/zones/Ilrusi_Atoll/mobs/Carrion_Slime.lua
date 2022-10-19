-----------------------------------
-- Area: Ilrusi Atoll (Extermination)
--  Mob: Carrion Slime
-----------------------------------
local ID = require("scripts/zones/Ilrusi_Atoll/IDs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()
    local slimeMob = GetMobByID(ID.mob.UNDEAD_SLIME, instance)
    local randVal  = math.random(1, 5)

    if randVal == 1 and slimeMob:getLocalVar("SlimeSpawned") == 0 then
        SpawnMob(ID.mob.UNDEAD_SLIME, instance)
        slimeMob:setLocalVar("SlimeSpawned", 1)
    else
        instance:setProgress(instance:getProgress() + 1)
    end
end

return entity
