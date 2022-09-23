-----------------------------------
-- Area: Temenos N T
--  Mob: Telchines Bard
-----------------------------------
require("scripts/globals/limbus")
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Temenos/IDs")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        if GetMobByID(ID.mob.TEMENOS_N_MOB[3]):isDead() and GetMobByID(ID.mob.TEMENOS_N_MOB[3]+1):isDead() then
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[3]):setStatus(xi.status.NORMAL)
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[3]+1):setStatus(xi.status.NORMAL)
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[3]+2):setStatus(xi.status.NORMAL)
        end
    end
end

return entity
