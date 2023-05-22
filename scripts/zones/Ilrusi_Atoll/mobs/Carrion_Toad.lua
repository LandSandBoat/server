-----------------------------------
-- Area: Ilrusi Atoll (Extermination)
--  Mob: Carrion Toad
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

        if
            (id == instance:getLocalVar("chosenMob1") or
            id == instance:getLocalVar("chosenMob2")) and
            math.random(1, 5) == 1
        then
            SpawnMob(ID.mob[xi.assault.mission.EXTERMINATION].UNDEAD_CRAB, instance)
        else
            xi.assault.progressInstance(mob, 1)
        end
    end
end

entity.onMobDespawn = function(mob)
end

return entity
