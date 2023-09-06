-----------------------------------
-- Area: Temenos
--  Mob: Abyssdweller Jhabdebb
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
local ID = zones[xi.zone.TEMENOS]
-----------------------------------
local entity = {}

entity.onMobEngaged = function(mob, target)
    if
        GetMobByID(ID.mob.TEMENOS_C_MOB[3] + 5):isDead() and GetMobByID(ID.mob.TEMENOS_C_MOB[3] + 6):isDead() and
        GetMobByID(ID.mob.TEMENOS_C_MOB[3] + 7):isDead() and GetMobByID(ID.mob.TEMENOS_C_MOB[3] + 8):isDead() and
        GetMobByID(ID.mob.TEMENOS_C_MOB[3] + 9):isDead() and GetMobByID(ID.mob.TEMENOS_C_MOB[3] + 10):isDead()
    then
        mob:setMod(xi.mod.SLASH_SDT, 1400)
        mob:setMod(xi.mod.PIERCE_SDT, 1400)
        mob:setMod(xi.mod.IMPACT_SDT, 1400)
        mob:setMod(xi.mod.HTH_SDT, 1400)
    else
        mob:setMod(xi.mod.SLASH_SDT, 300)
        mob:setMod(xi.mod.PIERCE_SDT, 300)
        mob:setMod(xi.mod.IMPACT_SDT, 300)
        mob:setMod(xi.mod.HTH_SDT, 300)
    end

    GetMobByID(ID.mob.TEMENOS_C_MOB[3] + 1):updateEnmity(target)
    GetMobByID(ID.mob.TEMENOS_C_MOB[3] + 2):updateEnmity(target)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        if
            GetMobByID(ID.mob.TEMENOS_C_MOB[3]):isDead() and
            GetMobByID(ID.mob.TEMENOS_C_MOB[3] + 1):isDead() and
            GetMobByID(ID.mob.TEMENOS_C_MOB[3] + 2):isDead()
        then
            GetNPCByID(ID.npc.TEMENOS_C_CRATE[3]):setStatus(xi.status.NORMAL)
        end
    end
end

return entity
