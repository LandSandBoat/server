-----------------------------------
-- Area: Apollyon NE
--  Mob: Troglodyte Dhalmel
-----------------------------------
require("scripts/globals/pathfind")
local ID = require("scripts/zones/Apollyon/IDs")
local flags = tpz.path.flag.NONE
local path =
{
    {525.180,-0.500,288.169},
    {542.354,-0.499,256.271},
    {546.451,-0.499,253.793},
    {582.242,-0.499,307.279},
    {590.586,-0.500,285.598},
    {590.569,-0.500,285.574},
    {530.585,-0.500,283.369},
    {525.971,-0.499,289.436}
}

function onMobSpawn(mob)
    local start = (mob:getID() - ID.mob.APOLLYON_NE_MOB[5]) - 1
    mob:setLocalVar("point", start)
end

function onMobRoam(mob)
    if not mob:isFollowingPath() then
        local point = math.random(#path)
        while point == mob:getLocalVar("point") do
            point = math.random(#path)
        end
        mob:setLocalVar("point", point)
        mob:pathTo(path[point][1], path[point][2], path[point][3], flags)
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        local allDead = true
        for i = 2, 9 do
            if GetMobByID(ID.mob.APOLLYON_NE_MOB[5]+i):isAlive() then
                allDead = false
                break
            end
        end
        if allDead then
            GetNPCByID(ID.npc.APOLLYON_NE_CRATE[5]):setStatus(tpz.status.NORMAL)
        end
    end
end
