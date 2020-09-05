-----------------------------------
-- Area: Temenos
--  Mob: Pee Qoho the Python
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Temenos/IDs")

function onMobEngaged(mob, target)
    if GetMobByID(ID.mob.TEMENOS_C_MOB[3]+18):isDead() and GetMobByID(ID.mob.TEMENOS_C_MOB[3]+19):isDead() and
        GetMobByID(ID.mob.TEMENOS_C_MOB[3]+20):isDead() and GetMobByID(ID.mob.TEMENOS_C_MOB[3]+21):isDead() and
        GetMobByID(ID.mob.TEMENOS_C_MOB[3]+22):isDead() and GetMobByID(ID.mob.TEMENOS_C_MOB[3]+23):isDead()
    then
        mob:setMod(tpz.mod.SLASHRES, 1400)
        mob:setMod(tpz.mod.PIERCERES, 1400)
        mob:setMod(tpz.mod.IMPACTRES, 1400)
        mob:setMod(tpz.mod.HTHRES, 1400)
    else
        mob:setMod(tpz.mod.SLASHRES, 300)
        mob:setMod(tpz.mod.PIERCERES, 300)
        mob:setMod(tpz.mod.IMPACTRES, 300)
        mob:setMod(tpz.mod.HTHRES, 300)
    end
    GetMobByID(ID.mob.TEMENOS_C_MOB[3]):updateEnmity(target)
    GetMobByID(ID.mob.TEMENOS_C_MOB[3]+1):updateEnmity(target)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        if GetMobByID(ID.mob.TEMENOS_C_MOB[3]):isDead() and GetMobByID(ID.mob.TEMENOS_C_MOB[3]+1):isDead() and
            GetMobByID(ID.mob.TEMENOS_C_MOB[3]+2):isDead()
        then
            GetNPCByID(ID.npc.TEMENOS_C_CRATE[3]):setStatus(tpz.status.NORMAL)
        end
    end
end
