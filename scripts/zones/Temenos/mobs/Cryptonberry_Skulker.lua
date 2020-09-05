-----------------------------------
-- Area: Temenos N T
--  Mob: Cryptonberry Skulker
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Temenos/IDs")

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        if GetMobByID(ID.mob.TEMENOS_N_MOB[6]):isDead() then
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[6]):setStatus(tpz.status.NORMAL)
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[6]+1):setStatus(tpz.status.NORMAL)
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[6]+2):setStatus(tpz.status.NORMAL)
        end
    end
end
