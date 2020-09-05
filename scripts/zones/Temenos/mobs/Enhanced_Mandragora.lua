-----------------------------------
-- Area: Temenos W T
--  Mob: Enhanced Mandragora
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
        {198.000, -81.000, -74.000},
        {198.000, -81.000, -86.000}
    },
    [1] = 
    {
        {202.000, -81.000, -86.000},
        {202.000, -81.000, -74.000}
    },
    [2] = 
    {
        {207.000, -81.000, -88.000},
        {193.000, -81.000, -88.000}
    },
    [3] = 
    {
        {208.000, -81.000, -73.000},
        {208.000, -81.000, -87.000}
    },
    [4] = 
    {
        {193.000, -81.000, -72.000},
        {207.000, -81.000, -72.000}
    },
    [5] = 
    {
        {192.000, -81.000, -87.000},
        {192.000, -81.000, -73.000}
    },
    [6] = 
    {
        {203.560, -80.000, -140.000},
        {232.680, -80.000, -140.000}
    },
    [7] = 
    {
        {205.640, -80.000, -140.000},
        {234.600, -80.000, -140.000}
    },
    [8] = 
    {
        {207.600, -80.000, -140.000},
        {236.560, -80.000, -140.000}
    },
}

function onMobRoam(mob)
    local offset = mob:getID() - ID.mob.TEMENOS_W_MOB[2]
    local pause = mob:getLocalVar("pause")
    if pause < os.time() then
        local point = (mob:getLocalVar("point") % 2)+1
        mob:setLocalVar("point", point)
        mob:pathTo(path[offset][point][1], path[offset][point][2], path[offset][point][3], flags)
        mob:setLocalVar("pause", os.time()+15)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local spawn = math.random(4) == 1
        local battlefield = mob:getBattlefield()

        if GetNPCByID(ID.npc.TEMENOS_W_GATE[2]):getAnimation() == tpz.animation.CLOSE_DOOR then
            tpz.limbus.handleDoors(battlefield, true, ID.npc.TEMENOS_W_GATE[2])
        end

        if spawn then
            for i = 0, 2 do
                if GetNPCByID(ID.npc.TEMENOS_W_CRATE[2]+i):getStatus() == tpz.status.DISAPPEAR then
                    local mobX = mob:getXPos()
                    local mobY = mob:getYPos()
                    local mobZ = mob:getZPos()
                    GetNPCByID(ID.npc.TEMENOS_W_CRATE[2]+i):setPos(mobX, mobY, mobZ)
                    tpz.limbus.spawnRandomCrate(ID.npc.TEMENOS_W_CRATE[2]+i, battlefield, "crateMaskF2", battlefield:getLocalVar("crateMaskF2"))
                    break
                end
            end
        end
    end
end
