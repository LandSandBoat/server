-----------------------------------
-- Area: Temenos N T
--  Mob: Cryptonberry Designator
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/limbus")
require("scripts/globals/pathfind")
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Temenos/IDs")
local flags = tpz.path.flag.NONE
local path =
{
    [3] = 
    {
        {-456.000, -80.000, 419.500},
        {-424.000, -80.000, 419.500}
    },
    [7] = 
    {
        {-459.500, -80.000, 416.000},
        {-459.500, -80.000, 408.000}
    },
    [11] = 
    {
        {-420.500, -80.000, 416.000},
        {-420.500, -80.000, 408.000}
    },
}

function onMobRoam(mob)
    local offset = mob:getID() - ID.mob.TEMENOS_N_MOB[6]
    local pause = mob:getLocalVar("pause")
    if pause < os.time() then
        local point = (mob:getLocalVar("point") % 2)+1
        mob:setLocalVar("point", point)
        mob:pathTo(path[offset][point][1], path[offset][point][2], path[offset][point][3], flags)
        if offset == 3 then
            mob:setLocalVar("pause", os.time()+30)
        else
            mob:setLocalVar("pause", os.time()+15)
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        if GetNPCByID(ID.npc.TEMENOS_N_GATE[6]):getAnimation() == tpz.animation.CLOSE_DOOR then
            tpz.limbus.handleDoors(mob:getBattlefield(), true, ID.npc.TEMENOS_N_GATE[6])
        end
    end
end
