-----------------------------------
-- Area: Temenos N T
--  Mob: Telchines Dragoon
-----------------------------------
require("scripts/globals/limbus")
require("scripts/globals/pathfind")
mixins = {require("scripts/mixins/job_special")}
local ID = require("scripts/zones/Temenos/IDs")
local flags = tpz.path.flag.NONE
local path =
{
    {50.000, 80.000, 419.500},
    {30.000, 80.000, 419.500}
}

function onMobRoam(mob)
    local pause = mob:getLocalVar("pause")
    if pause < os.time() then
        local point = (mob:getLocalVar("point") % 2)+1
        mob:setLocalVar("point", point)
        mob:pathTo(path[point][1], path[point][2], path[point][3], flags)
        mob:setLocalVar("pause", os.time()+10)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local battlefield = mob:getBattlefield()
        local random = battlefield:getLocalVar("randomF3")
        if random == 3 then
            battlefield:setLocalVar("randomF4", math.random(1, 4))
            tpz.limbus.handleDoors(battlefield, true, ID.npc.TEMENOS_N_GATE[3])
        end
    end
end
