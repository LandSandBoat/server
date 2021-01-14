-----------------------------------
-- Area: Garlaige Citadel
--   NM: Chandelier
-- Note: Spawned for quest "Hitting the Marquisate"
-----------------------------------
local ID = require("scripts/zones/Garlaige_Citadel/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

function onMobSpawn(mob)
    GetMobByID(ID.mob.CHANDELIER):setRespawnTime(0)
end

function onMobEngaged(mob, target)
    local ce = mob:getCE(target)
    local ve = mob:getVE(target)
    if (ce==0 and ve==0) then
        mob:setMobMod(tpz.mobMod.NO_DROPS, 1)
        mob:useMobAbility(511) -- self-destruct
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    GetNPCByID(ID.npc.CHANDELIER_QM):setLocalVar("chandelierCooldown", os.time() + 600) -- 10 minute timeout
end

return entity
