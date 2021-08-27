-----------------------------------
-- Area: Apollyon NW
--  Mob: Kaiser Behemoth
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/pathfind")
local ID = require("scripts/zones/Apollyon/IDs")
-----------------------------------
local entity = {}

local flags = xi.path.flag.NONE
local path =
{
    {-596.004, -0.254, 242.034},
    {-587.224, -0.254, 303.720},
    {-551.515, -0.254, 310.600},
    {-522.507, -0.254, 281.024},
    {-543.916, -0.254, 246.509},
    {-569.656, -0.254, 239.459}
}

entity.onMobRoam = function(mob)
    if not mob:isFollowingPath() then
        local point = math.random(#path)
        while point == mob:getLocalVar("point") do
            point = math.random(#path)
        end
        mob:setLocalVar("point", point)
        mob:pathTo(path[point][1], path[point][2], path[point][3], flags)
    end
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 60)
end

entity.onSpellPrecast = function(mob, spell)
    if spell:getID() == 218 then
        spell:setAoE(xi.magic.aoe.RADIAL)
        spell:setFlag(xi.magic.spellFlag.HIT_ALL)
        spell:setRadius(30)
        spell:setAnimation(280)
        spell:setMPCost(1)
    end
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        GetNPCByID(ID.npc.APOLLYON_NW_CRATE[5]):setStatus(xi.status.NORMAL)
    end
end

return entity
