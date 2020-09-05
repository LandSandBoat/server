-----------------------------------
-- Area: Apollyon SE
--  Mob: Flying Spear
-----------------------------------
require("scripts/globals/pathfind")
local ID = require("scripts/zones/Apollyon/IDs")
local flags = tpz.path.flag.NONE
local path =
{
    [1] = 
    {
        {509.874, 0.000, -310.010},
        {490.000, 0.000, -287.000}
    },
    [2] = 
    {
        {559.858, 0.000, -347.135},
        {540.000, 0.000, -347.000}
    },
    [3] = 
    {
        {597.587, 0.000, -348.038},
        {619.000, 0.000, -337.000}
    },
    [4] = 
    {
        {600.347, 0.000, -358.427},
        {599.808, 0.000, -377.934}
    },
    [5] = 
    {
        {525.602, 0.000, -353.234},
        {541.000, 0.000, -368.000}
    },
    [6] = 
    {
        {539.524, 0.000, -352.514},
        {559.506, 0.000, -349.762}
    },
    [7] = 
    {
        {613.174, 0.000, -357.948},
        {615.098, 0.000, -377.595}
    },
    [8] = 
    {
        {570.718, 0.000, -343.563},
        {564.009, 0.000, -314.711}
    }
}

function onMobRoam(mob)
    local offset = mob:getID() - ID.mob.APOLLYON_SE_MOB[4]
    local pause = mob:getLocalVar("pause")
    if pause < os.time() then
        local point = (mob:getLocalVar("point") % 2)+1
        mob:setLocalVar("point", point)
        mob:pathTo(path[offset][point][1], path[offset][point][2], path[offset][point][3], flags)
        mob:setLocalVar("pause", os.time()+15)
    end
end

function onMobSpawn(mob)
    mob:setMod(tpz.mod.UDMGMAGIC, -100)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local battlefield = mob:getBattlefield()
        battlefield:setLocalVar("killCountF4", battlefield:getLocalVar("killCountF4")+1)
        local killCount = battlefield:getLocalVar("killCountF4")
        GetMobByID(ID.mob.APOLLYON_SE_MOB[4]):setMod(tpz.mod.UDMGPHYS, -(8-killCount)*10)
        if killCount == 1 then
            GetNPCByID(ID.mob.APOLLYON_SE_MOB[4]):setStatus(tpz.status.DISAPPEAR)      
            GetMobByID(ID.mob.APOLLYON_SE_MOB[4]):spawn()
        elseif killCount == 8 then
            GetMobByID(ID.mob.APOLLYON_SE_MOB[4]):setMod(tpz.mod.UDMGMAGIC, 0)
        end
    end
end
