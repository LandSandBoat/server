-----------------------------------
-- Area: Arrapago Remnants
--  Mob: Archaic Rampart
-----------------------------------
mixins = {require("scripts/mixins/families/rampart")}
local ID = require("scripts/zones/Arrapago_Remnants/IDs")
require("scripts/globals/instance")
require("scripts/globals/status")
-----------------------------------
local entity = {}

function onMobSpawn(mob)
end

entity.onMobFight = function(mob, target)
    local instance = mob:getInstance()
    local popTime = mob:getLocalVar("lastPetPop")
    local POS = mob:getPos()
    local PET1 = GetMobByID((mob:getID() +1), instance)

    if os.time() - popTime > 15 then
        if (not PET1:isSpawned()) then
            PET1:setSpawn(POS.x, POS.y, POS.z, POS.rot)
            mob:useMobAbility(2034)
            mob:setLocalVar("lastPetPop", os.time())
            mob:timer(2500, function(mob)
            SpawnMob((mob:getID() +1), instance)
            end)
        end
    end
    if PET1:isSpawned() then
        PET1:updateEnmity(target)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

function onMobDespawn(mob)
end

return entity
