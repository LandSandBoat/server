-----------------------------------
-- Area: Temenos N T
--  Mob: Telchines Monk
-----------------------------------
require("scripts/globals/limbus")
require("scripts/globals/pathfind")
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Temenos/IDs")
local flags = tpz.path.flag.NONE
local path =
{
    [4] = 
    {
        {30.000, 80.000, 420.500},
        {10.000, 80.000, 420.500}
    },
    [5] = 
    {
        {70.000, 80.000, 420.500},
        {50.000, 80.000, 420.500}
    },
}

function onMobRoam(mob)
    local offset = mob:getID() - ID.mob.TEMENOS_N_MOB[3]
    local pause = mob:getLocalVar("pause")
    if pause < os.time() then
        local point = (mob:getLocalVar("point") % 2)+1
        mob:setLocalVar("point", point)
        mob:pathTo(path[offset][point][1], path[offset][point][2], path[offset][point][3], flags)
        mob:setLocalVar("pause", os.time()+10)
    end
end

function onMobDeath(mob, player, isKiller)
    if isKiller then
        local mobID = mob:getID()
        local battlefield = player:getBattlefield()
        local random = battlefield:getLocalVar("randomF3")

        if mobID - ID.mob.TEMENOS_N_MOB[3] == random - 1 then
            battlefield:setLocalVar("randomF4", math.random(1, 4))
            tpz.limbus.handleDoors(battlefield, true, ID.npc.TEMENOS_N_GATE[3])
        end
    end
end
