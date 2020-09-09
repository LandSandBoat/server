-----------------------------------
-- Area: Temenos W T
--  Mob: Enhanced Tiger
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/limbus")
require("scripts/globals/pathfind")
local ID = require("scripts/zones/Temenos/IDs")
local flags = tpz.path.flag.NONE
local path =
{
    [2] = 
    {
        {377.635, 74.000, -100.000},
        {343.635, 68.000, -100.000}
    },
    [6] = 
    {
        {340.000, 74.000, -137.500},
        {340.000, 68.000, -103.500}
    },

}

function onMobRoam(mob)
    local offset = mob:getID() - ID.mob.TEMENOS_W_MOB[1]
    local pause = mob:getLocalVar("pause")
    if pause < os.time() and (offset == 2 or offset == 6) then
        local point = (mob:getLocalVar("point") % 2)+1
        mob:setLocalVar("point", point)
        mob:pathTo(path[offset][point][1], path[offset][point][2], path[offset][point][3], flags)
        mob:setLocalVar("pause", os.time()+20)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local spawn = math.random(4) == 1
        local battlefield = mob:getBattlefield()

        if GetNPCByID(ID.npc.TEMENOS_W_GATE[1]):getAnimation() == tpz.animation.CLOSE_DOOR then
            tpz.limbus.handleDoors(battlefield, true, ID.npc.TEMENOS_W_GATE[1])
        end

        if spawn then
            for i = 0, 2 do
                if GetNPCByID(ID.npc.TEMENOS_W_CRATE[1]+i):getStatus() == tpz.status.DISAPPEAR then
                    local mobX = mob:getXPos()
                    local mobY = mob:getYPos()
                    local mobZ = mob:getZPos()
                    GetNPCByID(ID.npc.TEMENOS_W_CRATE[1]+i):setPos(mobX, mobY, mobZ)
                    tpz.limbus.spawnRandomCrate(ID.npc.TEMENOS_W_CRATE[1]+i, battlefield, "crateMaskF1", battlefield:getLocalVar("crateMaskF1"))
                    break
                end
            end
        end
    end
end
