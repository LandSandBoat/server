-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Nasus
-----------------------------------
local ID = require("scripts/zones/Yuhtunga_Jungle/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobDeath(mob, player, isKiller)
    local qm = GetNPCByID(ID.npc.TUNING_OUT_QM)
    qm:setLocalVar("NasusKilled", qm:getLocalVar("NasusKilled") + 1)
end

return entity
