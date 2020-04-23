-----------------------------------
-- Area: Apollyon SE
--  Mob: Inhumer
-----------------------------------
require("scripts/globals/pathfind")
local ID = require("scripts/zones/Apollyon/IDs")
local flags = tpz.path.flag.WALLHACK
local path =
{
    [1] = 
    {
        {391.345, 0.000, -362.357},
        {409.661, -0.500, -372.819}
    },
    [2] = 
    {
        {334.872, 0.000, -336.313},
        {341.842, -0.764, -319.744}
    },
    [3] = 
    {
        {362.613, 0.000, -276.235},
        {344.407, -1.398, -280.625}
    },
    [4] = 
    {
        {327.796, 0.000, -320.106},
        {336.038, -1.286, -310.834}
    },
    [5] = 
    {
        {326.597, 0.000, -313.956},
        {322.230, -0.493, -328.462}
    },
    [6] = 
    {
        {363.584, 0.000, -300.336},
        {348.563, -1.110, -312.928}
    },
    [7] = 
    {
        {331.868, 0.000, -337.062},
        {330.350, -0.481, -323.224}
    },
    [8] = 
    {
        {340.493, -0.879, -309.115},
        {339.728, -0.582, -320.195}
    }
}

function onMobRoam(mob)
    local offset = mob:getID() - ID.mob.APOLLYON_SE_MOB[3]
    local pause = mob:getLocalVar("pause")
    local start = mob:getLocalVar("start") == 1
    if pause < os.time() and start then
        local point = (mob:getLocalVar("point") % 2)+1
        mob:setLocalVar("point", point)
        mob:pathTo(path[offset][point][1], path[offset][point][2], path[offset][point][3], flags)
        mob:setLocalVar("pause", os.time()+30)
    end
end

function onMobSpawn(mob)
    mob:setMod(tpz.mod.HTHRES, 1500)
    mob:setMod(tpz.mod.IMPACTRES, 1500)
    mob:setMod(tpz.mod.PIERCERES, 0)
end

function onMobEngaged(mob, target)
    local start = mob:getLocalVar("start") == 1
    if not start then
        for i = 1, 8 do
            GetMobByID(ID.mob.APOLLYON_SE_MOB[3]+i):setLocalVar("pause", os.time()+(3 * i))
            GetMobByID(ID.mob.APOLLYON_SE_MOB[3]+i):setLocalVar("start", 1)
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local cratePos =
        {
            [1] = {366.000, -0.500, -313.000},
            [2] = {313.021, 0.000, -317.754},
            [3] = {376.097, 0.000, -259.382},
            [4] = {321.552, 0.000, -293.187},
            [5] = {337.399, -0.388, -313.442},
            [6] = {354.661, -0.072, -273.424},
        }
        local battlefield = mob:getBattlefield()
        battlefield:setLocalVar("killCountF3", battlefield:getLocalVar("killCountF3")+1)
        local killCount = battlefield:getLocalVar("killCountF3")
        local random = math.random(1, 6)
        if killCount == 2 then
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[3]):setPos(cratePos[random])
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[3]):setStatus(tpz.status.NORMAL)
        elseif killCount == 4 then
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[3]+1):setPos(cratePos[random])
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[3]+1):setStatus(tpz.status.NORMAL)
        elseif killCount == 8 then
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[3]+2):setPos(cratePos[random])
            GetNPCByID(ID.npc.APOLLYON_SE_CRATE[3]+2):setStatus(tpz.status.NORMAL)        
        end
    end
end
