-----------------------------------
-- Area: Temenos W T
--  Mob: Enhanced Beetle
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/limbus")
require("scripts/globals/pathfind")
local ID = require("scripts/zones/Temenos/IDs")
local flags = tpz.path.flag.NONE
local path =
{
    [0] =
    {
        {18.000, 80.000, -140.000},
        {8.000, 80.000, -140.000}
    },
    [1] = 
    {
        {20.000, 80.000, -138.000},
        {20.000, 80.000, -128.000}
    },
    [2] = 
    {
        {22.000, 80.000, -140.000},
        {32.000, 80.000, -140.000}
    },
    [3] = 
    {
        {58.000, 80.000, -140.000},
        {48.000, 80.000, -140.000}
    },
    [4] = 
    {
        {60.000, 80.000, -138.000},
        {60.000, 80.000, -128.000}
    },
    [5] = 
    {
        {62.000, 80.000, -140.000},
        {72.000, 80.000, -140.000}
    },
}

function onMobRoam(mob)
    local offset = mob:getID() - ID.mob.TEMENOS_W_MOB[3]
    local pause = mob:getLocalVar("pause")
    if pause < os.time() then
        local point = (mob:getLocalVar("point") % 2)+1
        mob:setLocalVar("point", point)
        mob:pathTo(path[offset][point][1], path[offset][point][2], path[offset][point][3], flags)
        mob:setLocalVar("pause", os.time()+30)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local spawn = math.random(3) == 1
        local battlefield = mob:getBattlefield()
        if GetNPCByID(ID.npc.TEMENOS_W_GATE[3]):getAnimation() == tpz.animation.CLOSE_DOOR then
            tpz.limbus.handleDoors(battlefield, true, ID.npc.TEMENOS_W_GATE[3])
        end

        if spawn then
            for i = 0, 2 do
                if GetNPCByID(ID.npc.TEMENOS_W_CRATE[3]+i):getStatus() == tpz.status.DISAPPEAR then
                    local mobX = mob:getXPos()
                    local mobY = mob:getYPos()
                    local mobZ = mob:getZPos()
                    GetNPCByID(ID.npc.TEMENOS_W_CRATE[3]+i):setPos(mobX, mobY, mobZ)
                    tpz.limbus.spawnRandomCrate(ID.npc.TEMENOS_W_CRATE[3]+i, battlefield, "crateMaskF3", battlefield:getLocalVar("crateMaskF3"))
                    break
                end
            end
        end
    end
end
