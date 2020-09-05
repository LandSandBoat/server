-----------------------------------
-- Area: Temenos E T
--  Mob: Fire Elemental
-----------------------------------
require("scripts/globals/limbus")
local ID = require("scripts/zones/Temenos/IDs")

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local battlefield = mob:getBattlefield()
        if battlefield:getLocalVar("crateOpenedF1") ~= 1 then
            if mobID >= ID.mob.TEMENOS_C_MOB[2] then
                GetMobByID(ID.mob.TEMENOS_C_MOB[2]):setMod(tpz.mod.FIREDEF, -128)
                if GetMobByID(ID.mob.TEMENOS_C_MOB[2]+4):isAlive() then
                    DespawnMob(ID.mob.TEMENOS_C_MOB[2]+4)
                    SpawnMob(ID.mob.TEMENOS_C_MOB[2]+10)
                end
            else
                local mobX = mob:getXPos()
                local mobY = mob:getYPos()
                local mobZ = mob:getZPos()
                local crateID = ID.npc.TEMENOS_E_CRATE[1] + (mobID - ID.mob.TEMENOS_E_MOB[1])
                GetNPCByID(crateID):setPos(mobX, mobY, mobZ)
                tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF1", battlefield:getLocalVar("crateMaskF1"), true)
            end
        end
    end
end
