-----------------------------------
-- Area: Ilrusi Atoll (Extermination)
--  Mob: Carrion Leech
-----------------------------------
require("scripts/globals/assault")
local ID = require("scripts/zones/Ilrusi_Atoll/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        local instance = mob:getInstance()
        local id = mob:getID()

        -- Spawn NM if placeholder
        -- Otherwise progress instance
        if
            id == instance:getLocalVar("chosenMob1") or
            id == instance:getLocalVar("chosenMob2")
        then
            SpawnMob(ID.mob[xi.assault.mission.EXTERMINATION].UNDEAD_LEECH, instance)
        else
            xi.assault.progressInstance(mob, 1)
        end
    end
end

entity.onMobDespawn = function(mob)
end

return entity
