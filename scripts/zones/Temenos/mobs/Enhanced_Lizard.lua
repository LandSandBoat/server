-----------------------------------
-- Area: Temenos W T
--  Mob: Enhanced Lizard
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
        {-87.000, -80.000, -150.500},
        {-153.000, -80.000, -150.500}
    },
    [1] = 
    {
        {-150.000, -80.000, -147.000},
        {-130.000, -80.000, -147.000}
    },
    [2] = 
    {
        {-90.000, -80.000, -147.000},
        {-110.000, -80.000, -147.000}
    },
    [3] = 
    {
        {-153.000, -80.000, -142.000},
        {-87.000, -80.000, -142.000}
    },
    [4] = 
    {
        {-87.000, -80.000, -138.000},
        {-153.000, -80.000, -138.000}
    },
    [5] = 
    {
        {-111.960, -80.000, -140.000},
        {-127.960, -80.000, -140.000}
    },
    [6] = 
    {
        {-150.000, -80.000, -133.000},
        {-130.000, -80.000, -133.000}
    },
    [7] = 
    {
        {-90.000, -80.000, -133.000},
        {-110.000, -80.000, -133.000}
    },
    [8] = 
    {
        {-153.000, -80.000, -129.500},
        {-87.000, -80.000, -129.500}
    },
}

function onMobRoam(mob)
    local offset = mob:getID() - ID.mob.TEMENOS_W_MOB[4]
    local pause = mob:getLocalVar("pause")
    if pause < os.time() then
        local point = (mob:getLocalVar("point") % 2)+1
        mob:setLocalVar("point", point)
        mob:pathTo(path[offset][point][1], path[offset][point][2], path[offset][point][3], flags)
        if offset == 5 then
            mob:setLocalVar("pause", os.time()+10)
        elseif offset == 1 or offset == 2 or offset == 6 or offset == 7 then
            mob:setLocalVar("pause", os.time()+17)
        else
            mob:setLocalVar("pause", os.time()+25)
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local spawn = math.random(4) == 1
        local battlefield = mob:getBattlefield()

        if GetNPCByID(ID.npc.TEMENOS_W_GATE[4]):getAnimation() == tpz.animation.CLOSE_DOOR then
            tpz.limbus.handleDoors(battlefield, true, ID.npc.TEMENOS_W_GATE[4])
        end

        if spawn then
            for i = 0, 2 do
                if GetNPCByID(ID.npc.TEMENOS_W_CRATE[4]+i):getStatus() == tpz.status.DISAPPEAR then
                    local mobX = mob:getXPos()
                    local mobY = mob:getYPos()
                    local mobZ = mob:getZPos()
                    GetNPCByID(ID.npc.TEMENOS_W_CRATE[4]+i):setPos(mobX, mobY, mobZ)
                    tpz.limbus.spawnRandomCrate(ID.npc.TEMENOS_W_CRATE[4]+i, battlefield, "crateMaskF4", battlefield:getLocalVar("crateMaskF4"))
                    break
                end
            end
        end
    end
end
