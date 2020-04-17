-----------------------------------
-- Area: Temenos N T
--  Mob: Kindred Black Mage
-----------------------------------
require("scripts/globals/limbus")
require("scripts/globals/pathfind")
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Temenos/IDs")
local flags = tpz.path.flag.WALLHACK + tpz.path.flag.RUN
local path =
{
    [5] = 
    {
        {-148.860, -80.000, 427.000},
        {-91.860, -80.000, 427.000}
    },
    [6] = 
    {
        {-148.860, -80.000, 430.000},
        {-91.860, -80.000, 430.000}
    },
    [7] = 
    {
        {-91.860, -80.000, 410.000},
        {-148.860, -80.000, 410.000}
    },
    [8] = 
    {
        {-91.860, -80.000, 413.000},
        {-148.860, -80.000, 413.000}
    },
}

function onMobRoam(mob)
    local offset = mob:getID() - ID.mob.TEMENOS_N_MOB[4]
    local pause = mob:getLocalVar("pause")
    if pause < os.time() then
        local point = (mob:getLocalVar("point") % 2)+1
        mob:setLocalVar("point", point)
        mob:pathTo(path[offset][point][1], path[offset][point][2], path[offset][point][3], flags)
        mob:setLocalVar("pause", os.time()+10)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local battlefield = mob:getBattlefield()
        local random = battlefield:getLocalVar("randomF4")

        if mob:getID() - ID.mob.TEMENOS_N_MOB[4] == random + 4 then
            tpz.limbus.handleDoors(battlefield, true, ID.npc.TEMENOS_N_GATE[4])
        end
    end
end
