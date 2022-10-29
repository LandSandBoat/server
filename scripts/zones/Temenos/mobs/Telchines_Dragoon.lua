-----------------------------------
-- Area: Temenos N T
--  Mob: Telchines Dragoon
-----------------------------------
require("scripts/globals/limbus")
require("scripts/globals/pathfind")
mixins = { require("scripts/mixins/job_special") }
local ID = require("scripts/zones/Temenos/IDs")
-----------------------------------
local entity = {}

local flags = xi.path.flag.NONE
local pathNodes =
{
    { 50.000, 80.000, 419.500 },
    { 30.000, 80.000, 419.500 },
}

entity.onMobRoam = function(mob)
    local pause = mob:getLocalVar("pause")
    if pause < os.time() then
        local point = (mob:getLocalVar("point") % 2) + 1
        mob:setLocalVar("point", point)
        mob:pathTo(pathNodes[point][1], pathNodes[point][2], pathNodes[point][3], flags)
        mob:setLocalVar("pause", os.time() + 10)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local battlefield = mob:getBattlefield()
        local random = battlefield:getLocalVar("randomF3")
        if random == 3 then
            battlefield:setLocalVar("randomF4", math.random(1, 4))
            xi.limbus.handleDoors(battlefield, true, ID.npc.TEMENOS_N_GATE[3])
        end
    end
end

return entity
