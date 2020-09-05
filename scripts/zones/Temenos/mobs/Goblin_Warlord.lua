-----------------------------------
-- Area: Temenos N T
--  Mob: Goblin Warlord
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Temenos/IDs")

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        if GetMobByID(ID.mob.TEMENOS_N_MOB[7]):isDead() and GetMobByID(ID.mob.TEMENOS_N_MOB[7]+1):isDead() and
            GetMobByID(ID.mob.TEMENOS_N_MOB[7]+2):isDead() and GetMobByID(ID.mob.TEMENOS_N_MOB[7]+3):isDead() and
            GetMobByID(ID.mob.TEMENOS_N_MOB[7]+4):isDead()
        then
            GetNPCByID(ID.npc.TEMENOS_N_CRATE[7]):setStatus(tpz.status.NORMAL)
        end
    end
end
