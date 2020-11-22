-----------------------------------
-- Area: Temenos E T
--  Mob: Earth Elemental
-----------------------------------
require("scripts/globals/limbus")
local ID = require("scripts/zones/Temenos/IDs")

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local battlefield = mob:getBattlefield()
        if battlefield:getLocalVar("crateOpenedF4") ~= 1 then
            local mobID = mob:getID()
            if mobID >= ID.mob.TEMENOS_C_MOB[2] then
                GetMobByID(ID.mob.TEMENOS_C_MOB[2]):setMod(tpz.mod.EARTHDEF, -128)
                if GetMobByID(ID.mob.TEMENOS_C_MOB[2]+7):isAlive() then
                    DespawnMob(ID.mob.TEMENOS_C_MOB[2]+7)
                    SpawnMob(ID.mob.TEMENOS_C_MOB[2]+13)
                end
            else
                local mobX = mob:getXPos()
                local mobY = mob:getYPos()
                local mobZ = mob:getZPos()
                local crateID = ID.npc.TEMENOS_E_CRATE[4] + (mobID - ID.mob.TEMENOS_E_MOB[4])
                GetNPCByID(crateID):setPos(mobX, mobY, mobZ)
                tpz.limbus.spawnRandomCrate(crateID, player, "crateMaskF4", battlefield:getLocalVar("crateMaskF4"), true)
            end
        end
    end
end
