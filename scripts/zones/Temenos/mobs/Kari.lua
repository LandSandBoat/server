-----------------------------------
-- Area: Temenos N T
--  Mob: Kari
-----------------------------------
require("scripts/globals/limbus")
require("scripts/globals/pathfind")
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Temenos/IDs")
local flags = tpz.path.flag.WALLHACK
local path =
{
    {185.000, -82.000, 465.000},
    {215.000, -82.000, 465.000},
    {215.000, -82.000, 495.500},
    {185.000, -82.000, 495.000}
}

function onMobRoam(mob)
    local pause = mob:getLocalVar("pause")
    if pause < os.time() then
        local point = (mob:getLocalVar("point") % 4)+1
        mob:setLocalVar("point", point)
        mob:pathTo(path[point][1], path[point][2], path[point][3], flags)
        mob:setLocalVar("pause", os.time()+15)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local battlefield = mob:getBattlefield()
        battlefield:setLocalVar("randomF3", math.random(1,3))
        tpz.limbus.handleDoors(battlefield, true, ID.npc.TEMENOS_N_GATE[2])
    end
end
