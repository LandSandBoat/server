-----------------------------------
-- Area: Temenos E T
--  Mob: Air Elemental
-----------------------------------
require("scripts/globals/limbus")
require("scripts/globals/pathfind")
local ID = require("scripts/zones/Temenos/IDs")
local flags = tpz.path.flag.NONE
local path =
{
    [1] = 
    {
        {20.000, 6.000, 150.000},
        {20.000, 6.000, 142.640}
    },
    [3] = 
    {
        {60.000, 6.000, 150.000},
        {60.000, 6.000, 142.640}
    },
}

function onMobRoam(mob)
    if mob:getBattlefieldID() == 1300 then
        local offset = mob:getID() - ID.mob.TEMENOS_E_MOB[3]
        local pause = mob:getLocalVar("pause")
        if pause < os.time() and offset == 1 or offset == 3 then
            local point = (mob:getLocalVar("point") % 2)+1
            mob:setLocalVar("point", point)
            mob:pathTo(path[offset][point][1], path[offset][point][2], path[offset][point][3], flags)
            mob:setLocalVar("pause", os.time()+5)
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local battlefield = mob:getBattlefield()
        if battlefield:getLocalVar("crateOpenedF3") ~= 1 then
            if mobID >= ID.mob.TEMENOS_C_MOB[2] then
                GetMobByID(ID.mob.TEMENOS_C_MOB[2]):setMod(tpz.mod.WINDDEF, -128)
                if GetMobByID(ID.mob.TEMENOS_C_MOB[2]+6):isAlive() then
                    DespawnMob(ID.mob.TEMENOS_C_MOB[2]+6)
                    SpawnMob(ID.mob.TEMENOS_C_MOB[2]+12)
                end
            else
                local mobX = mob:getXPos()
                local mobY = mob:getYPos()
                local mobZ = mob:getZPos()
                local crateID = ID.npc.TEMENOS_E_CRATE[3] + (mobID - ID.mob.TEMENOS_E_MOB[3])
                GetNPCByID(crateID):setPos(mobX, mobY, mobZ)
                tpz.limbus.spawnRandomCrate(crateID, battlefield, "crateMaskF3", battlefield:getLocalVar("crateMaskF3"), true)
            end
        end
    end
end
