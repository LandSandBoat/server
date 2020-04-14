-----------------------------------
-- Area: Temenos E T
--  Mob: Mystic Avatar
-----------------------------------
require("scripts/globals/limbus")
local ID = require("scripts/zones/Temenos/IDs")

function onMobSpawn(mob)
    local mobID = mob:getID()
    if mobID == ID.mob.TEMENOS_C_MOB[2] then --Carbuncle (Central Temenos 2nd Floor)
        mob:setMod(tpz.mod.FIREDEF, 256)
        mob:setMod(tpz.mod.ICEDEF, 256)
        mob:setMod(tpz.mod.WINDDEF, 256)
        mob:setMod(tpz.mod.EARTHDEF, 256)
        mob:setMod(tpz.mod.THUNDERDEF, 256)
        mob:setMod(tpz.mod.WATERDEF, 256)
        mob:setMod(tpz.mod.LIGHTDEF, 256)
        mob:setMod(tpz.mod.DARKDEF, -128)
    end
end

function onMobEngaged(mob, target)
    local mobID = mob:getID()
    if mobID == ID.mob.TEMENOS_C_MOB[2] then --Carbuncle (Central Temenos 2nd Floor)
        GetMobByID(ID.mob.TEMENOS_C_MOB[2]+2):updateEnmity(target)
        GetMobByID(ID.mob.TEMENOS_C_MOB[2]+1):updateEnmity(target)
    end
end

function onMobDeath(mob, player, isKiller)
    if isKiller then
        local mobID = mob:getID()
        local battlefield = player:getBattlefield()

        if mobID == ID.mob.TEMENOS_E_MOB[1]+4 then --Ifrit
            local crateMask = battlefield:getLocalVar("crateMaskF1")
            if crateMask == 0 then
                tpz.limbus.handleDoors(battlefield, true, ID.npc.TEMENOS_E_GATE[1])
            end
        elseif mobID == ID.mob.TEMENOS_E_MOB[2]+4 then --Shiva
            local crateMask = battlefield:getLocalVar("crateMaskF2")
            if crateMask == 0 then
                tpz.limbus.handleDoors(battlefield, true, ID.npc.TEMENOS_E_GATE[2])
            end
        elseif mobID == ID.mob.TEMENOS_E_MOB[3]+4 then --Garuda
            local crateMask = battlefield:getLocalVar("crateMaskF3")
            if crateMask == 0 then
                tpz.limbus.handleDoors(battlefield, true, ID.npc.TEMENOS_E_GATE[3])
            end
        elseif mobID == ID.mob.TEMENOS_E_MOB[4]+4 then --Titan
            local crateMask = battlefield:getLocalVar("crateMaskF4")
            if crateMask == 0 then
                tpz.limbus.handleDoors(battlefield, true, ID.npc.TEMENOS_E_GATE[4])
            end
        elseif mobID == ID.mob.TEMENOS_E_MOB[5]+4 then --Ramuh
            local crateMask = battlefield:getLocalVar("crateMaskF5")
            if crateMask == 0 then
                tpz.limbus.handleDoors(battlefield, true, ID.npc.TEMENOS_E_GATE[5])
            end
        elseif mobID == ID.mob.TEMENOS_E_MOB[6]+4 then --Leviathan
            local crateMask = battlefield:getLocalVar("crateMaskF6")
            if crateMask == 0 then
                tpz.limbus.handleDoors(battlefield, true, ID.npc.TEMENOS_E_GATE[6])
            end
        elseif mobID == ID.mob.TEMENOS_C_MOB[2]+9 then --Ifrit (Central Temenos 2nd Floor)
            GetMobByID(ID.mob.TEMENOS_C_MOB[2]):setMod(tpz.mod.FIREDEF, -128)
            if GetMobByID(ID.mob.TEMENOS_C_MOB[2]+4):isAlive() then
                DespawnMob(ID.mob.TEMENOS_C_MOB[2]+4)
                SpawnMob(ID.mob.TEMENOS_C_MOB[2]+10)
            end
        elseif mobID == ID.mob.TEMENOS_C_MOB[2]+10 then --Shiva (Central Temenos 2nd Floor)
            GetMobByID(ID.mob.TEMENOS_C_MOB[2]):setMod(tpz.mod.ICEDEF, -128)
            if GetMobByID(ID.mob.TEMENOS_C_MOB[2]+5):isAlive() then
                DespawnMob(ID.mob.TEMENOS_C_MOB[2]+5)
                SpawnMob(ID.mob.TEMENOS_C_MOB[2]+11)
            end
        elseif mobID == ID.mob.TEMENOS_C_MOB[2]+11 then --Garuda (Central Temenos 2nd Floor)
            GetMobByID(ID.mob.TEMENOS_C_MOB[2]):setMod(tpz.mod.WINDDEF, -128)
            if GetMobByID(ID.mob.TEMENOS_C_MOB[2]+6):isAlive() then
                DespawnMob(ID.mob.TEMENOS_C_MOB[2]+6)
                SpawnMob(ID.mob.TEMENOS_C_MOB[2]+12)
            end
        elseif mobID == ID.mob.TEMENOS_C_MOB[2]+12 then --Titan (Central Temenos 2nd Floor)
            GetMobByID(ID.mob.TEMENOS_C_MOB[2]):setMod(tpz.mod.EARTHDEF, -128)
            if GetMobByID(ID.mob.TEMENOS_C_MOB[2]+7):isAlive() then
                DespawnMob(ID.mob.TEMENOS_C_MOB[2]+7)
                SpawnMob(ID.mob.TEMENOS_C_MOB[2]+13)
            end
        elseif mobID == ID.mob.TEMENOS_C_MOB[2]+13 then --Ramuh (Central Temenos 2nd Floor)
            GetMobByID(ID.mob.TEMENOS_C_MOB[2]):setMod(tpz.mod.THUNDERDEF, -128)
            if GetMobByID(ID.mob.TEMENOS_C_MOB[2]+8):isAlive() then
                DespawnMob(ID.mob.TEMENOS_C_MOB[2]+8)
                SpawnMob(ID.mob.TEMENOS_C_MOB[2]+14)
            end
        elseif mobID == ID.mob.TEMENOS_C_MOB[2]+14 then --Leviathan (Central Temenos 2nd Floor)
            GetMobByID(ID.mob.TEMENOS_C_MOB[2]):setMod(tpz.mod.WATERDEF, -128)
            if GetMobByID(ID.mob.TEMENOS_C_MOB[2]+3):isAlive() then
                DespawnMob(ID.mob.TEMENOS_C_MOB[2]+3)
                SpawnMob(ID.mob.TEMENOS_C_MOB[2]+9)
            end
        elseif mobID == ID.mob.TEMENOS_C_MOB[2] then --Carbuncle (Central Temenos 2nd Floor)
            if GetMobByID(ID.mob.TEMENOS_C_MOB[2]+1):isDead() and GetMobByID(ID.mob.TEMENOS_C_MOB[2]+2):isDead() then
                GetNPCByID(ID.npc.TEMENOS_C_CRATE[2]):setStatus(tpz.status.NORMAL)
            end
        end
    end
end
