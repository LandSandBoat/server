-----------------------------------
-- Area: Temenos Central Floor
--  Mob: Enhanced Ahriman
-----------------------------------
local ID = require("scripts/zones/Temenos/IDs")

function onMobEngaged(mob, target)
    if GetMobByID(ID.mob.TEMENOS_C_MOB[1]+4):isDead() then
        mob:addStatusEffect(tpz.effect.REGAIN, 7, 3, 0)
        mob:addStatusEffect(tpz.effect.REGEN, 50, 3, 0)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        if GetMobByID(ID.mob.TEMENOS_C_MOB[1]):isDead() and GetMobByID(ID.mob.TEMENOS_C_MOB[1]+1):isDead() and
            GetMobByID(ID.mob.TEMENOS_C_MOB[1]+2):isDead() and GetMobByID(ID.mob.TEMENOS_C_MOB[1]+3):isDead() and
            GetMobByID(ID.mob.TEMENOS_C_MOB[1]+4):isDead()
        then
            local mobX = mob:getXPos()
            local mobY = mob:getYPos()
            local mobZ = mob:getZPos()
            GetNPCByID(ID.npc.TEMENOS_C_CRATE[1]):setPos(mobX, mobY, mobZ)
            GetNPCByID(ID.npc.TEMENOS_C_CRATE[1]):setStatus(tpz.status.NORMAL)
        end
    end
end
