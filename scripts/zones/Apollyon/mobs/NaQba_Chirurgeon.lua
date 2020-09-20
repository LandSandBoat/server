-----------------------------------
-- Area: Apollyon CS
--  Mob: Na'Qba Chirurgeon
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Apollyon/IDs")

function onMobSpawn(mob)
    mob:setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
end

function onMobEngaged(mob, target)
    local battlefield = mob:getBattlefield()
    if battlefield:getLocalVar("startTime") == 0 then
        battlefield:setLocalVar("startTime", battlefield:getRemainingTime())
    end
    SpawnMob(ID.mob.APOLLYON_CS_MOB[2]+1):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
    SpawnMob(ID.mob.APOLLYON_CS_MOB[2]+2):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
    SpawnMob(ID.mob.APOLLYON_CS_MOB[2]+3):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
    mob:setLocalVar("wave", 1)
end

function onMobFight(mob, target)
    local battlefield = mob:getBattlefield()
    if battlefield then
        local mobX = mob:getXPos()
        local mobY = mob:getYPos()
        local mobZ = mob:getZPos()
        local remainingTime = battlefield:getRemainingTime()
        local startTime = battlefield:getLocalVar("startTime")
        local wave = mob:getLocalVar("wave")
    
        if GetMobByID(ID.mob.APOLLYON_CS_MOB[2]+1):isDead() and GetMobByID(ID.mob.APOLLYON_CS_MOB[2]+2):isDead()
            and GetMobByID(ID.mob.APOLLYON_CS_MOB[3]+3):isDead() and wave == 1
        then
            mob:setLocalVar("wave", 2)
            GetMobByID(ID.mob.APOLLYON_CS_MOB[2]+4):setSpawn(mobX, mobY, mobZ)
            GetMobByID(ID.mob.APOLLYON_CS_MOB[2]+4):setPos(mobX, mobY, mobZ)
            SpawnMob(ID.mob.APOLLYON_CS_MOB[2]+4):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
            GetMobByID(ID.mob.APOLLYON_CS_MOB[2]+5):setSpawn(mobX, mobY, mobZ)
            GetMobByID(ID.mob.APOLLYON_CS_MOB[2]+5):setPos(mobX, mobY, mobZ)
            SpawnMob(ID.mob.APOLLYON_CS_MOB[2]+5):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
            GetMobByID(ID.mob.APOLLYON_CS_MOB[2]+6):setSpawn(mobX, mobY, mobZ)
            GetMobByID(ID.mob.APOLLYON_CS_MOB[2]+6):setPos(mobX, mobY, mobZ)
            SpawnMob(ID.mob.APOLLYON_CS_MOB[2]+6):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
        elseif GetMobByID(ID.mob.APOLLYON_CS_MOB[2]+4):isDead() and GetMobByID(ID.mob.APOLLYON_CS_MOB[2]+5):isDead()
            and GetMobByID(ID.mob.APOLLYON_CS_MOB[2]+6):isDead() and wave == 2
        then
            mob:setLocalVar("wave", 1)
            GetMobByID(ID.mob.APOLLYON_CS_MOB[2]+1):setSpawn(mobX, mobY, mobZ)
            GetMobByID(ID.mob.APOLLYON_CS_MOB[2]+1):setPos(mobX, mobY, mobZ)
            SpawnMob(ID.mob.APOLLYON_CS_MOB[2]+1):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
            GetMobByID(ID.mob.APOLLYON_CS_MOB[2]+2):setSpawn(mobX, mobY, mobZ)
            GetMobByID(ID.mob.APOLLYON_CS_MOB[2]+2):setPos(mobX, mobY, mobZ)
            SpawnMob(ID.mob.APOLLYON_CS_MOB[2]+2):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
            GetMobByID(ID.mob.APOLLYON_CS_MOB[2]+3):setSpawn(mobX, mobY, mobZ)
            GetMobByID(ID.mob.APOLLYON_CS_MOB[2]+3):setPos(mobX, mobY, mobZ)
            SpawnMob(ID.mob.APOLLYON_CS_MOB[2]+3):setMobMod(tpz.mobMod.SUPERLINK, mob:getShortID())
        end
    
        if remainingTime <= startTime*0.66 then
            if GetMobByID(ID.mob.APOLLYON_CS_MOB[1]):isAlive() and not GetMobByID(ID.mob.APOLLYON_CS_MOB[1]):isEngaged() then
                battlefield:setLocalVar("startTime", battlefield:getRemainingTime())
                GetMobByID(ID.mob.APOLLYON_CS_MOB[1]):updateEnmity(target)
            elseif GetMobByID(ID.mob.APOLLYON_CS_MOB[3]):isAlive() and not GetMobByID(ID.mob.APOLLYON_CS_MOB[3]):isEngaged() then
                battlefield:setLocalVar("startTime", battlefield:getRemainingTime())
                GetMobByID(ID.mob.APOLLYON_CS_MOB[3]):updateEnmity(target)
            end
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        if GetMobByID(ID.mob.APOLLYON_CS_MOB[1]):isDead() and GetMobByID(ID.mob.APOLLYON_CS_MOB[3]):isDead() then
            GetNPCByID(ID.npc.APOLLYON_CS_CRATE):setStatus(tpz.status.NORMAL)
        elseif GetMobByID(ID.mob.APOLLYON_CS_MOB[1]):isAlive() and GetMobByID(ID.mob.APOLLYON_CS_MOB[3]):isAlive() then
            GetNPCByID(ID.npc.APOLLYON_CS_CRATE+1):setStatus(tpz.status.NORMAL)
        else
            GetNPCByID(ID.npc.APOLLYON_CS_CRATE+2):setStatus(tpz.status.NORMAL)
        end
    end
end
