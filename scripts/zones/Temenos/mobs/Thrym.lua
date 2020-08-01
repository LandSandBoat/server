-----------------------------------
-- Area: Temenos N T
--  Mob: Thrym
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Temenos/IDs")

function onMobEngaged(mob, target)
    GetMobByID(ID.mob.TEMENOS_N_MOB[2]):updateEnmity(target)
    GetMobByID(ID.mob.TEMENOS_N_MOB[2]+2):updateEnmity(target)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        if GetMobByID(ID.mob.TEMENOS_N_MOB[2]):isDead() and GetMobByID(ID.mob.TEMENOS_N_MOB[2]+2):isDead() then
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[2]):setStatus(tpz.status.NORMAL)
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[2]+1):setStatus(tpz.status.NORMAL)
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[2]+2):setStatus(tpz.status.NORMAL)
        end
    end
end
