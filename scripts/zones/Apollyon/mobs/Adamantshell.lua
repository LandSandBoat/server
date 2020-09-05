-----------------------------------
-- Area: Apollyon SE
--  Mob: Adamantshell
-----------------------------------
require("scripts/globals/pathfind")
local ID = require("scripts/zones/Apollyon/IDs")
local flags = tpz.path.flag.WALLHACK
local path =
{
    [1] = 
    {
        {139.903, -1.770, -497.193},
        {146.494, -0.112, -504.494}
    },
    [2] = 
    {
        {135.608, -0.261, -480.383},
        {138.953, -1.907, -495.490}
    },
    [3] = 
    {
        {128.531, -0.247, -505.639},
        {138.000, -2.000, -497.000}
    },
    [4] = 
    {
        {183.732, -0.048, -555.318},
        {184.608, -0.585, -536.562}
    },
    [5] = 
    {
        {184.608, -0.585, -536.562},
        {183.732, -0.048, -555.318}
    },
    [6] = 
    {
        {215.468, 0.000, -432.219},
        {195.000, 0.000, -446.000}
    },
    [7] = 
    {
        {212.263, 0.000, -440.719},
        {189.992, 0.000, -441.419}
    },
    [8] = 
    {
        {205.544, 0.000, -448.419},
        {189.888, 0.000, -434.880}
    }
}

function onPath(mob)
    mob:setLocalVar("pause", os.time()+1)
end

function onMobRoam(mob)
    local offset = mob:getID() - ID.mob.APOLLYON_SE_MOB[2]
    local pause = mob:getLocalVar("pause")
    if pause < os.time() then
        local point = (mob:getLocalVar("point") % 2)+1
        mob:setLocalVar("point", point)
        mob:pathTo(path[offset][point][1], path[offset][point][2], path[offset][point][3], flags)
        mob:setLocalVar("pause", os.time()+60)
    end
end

function onMobSpawn(mob)
    mob:setMod(tpz.mod.SLASHRES, 0)
    mob:setMod(tpz.mod.PIERCERES, 1500)
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local battlefield = mob:getBattlefield()
        battlefield:setLocalVar("killCountF2", battlefield:getLocalVar("killCountF2")+1)
        local killCount = battlefield:getLocalVar("killCountF2")
        if killCount == 2 then
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[2]):setStatus(tpz.status.NORMAL)
        elseif killCount == 4 then
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[2]+1):setStatus(tpz.status.NORMAL)
        elseif killCount == 8 then
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[2]+2):setStatus(tpz.status.NORMAL)        
        end
    end
end
