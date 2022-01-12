-----------------------------------
-- Area: Apollyon SE, Floor 2
--  Mob: Tieholtsodi
-----------------------------------
require("scripts/zones/Apollyon/helpers/apollyon_se")
require("scripts/globals/pathfind")
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

local flags = xi.path.flag.WALLHACK
local path =
{
    {149.587, -0.293, -526.395},
    {145.010, 0.000, -438.159}
}

entity.onMobRoam = function(mob)
    local pause = mob:getLocalVar("pause")

    if pause < os.time() then
        local point = (mob:getLocalVar("point") % 2) + 1
        mob:setLocalVar("point", point)
        mob:pathTo(path[point][1], path[point][2], path[point][3], flags)
        mob:setLocalVar("pause", os.time() + 40)
    end
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SLASH_SDT, 0)
    mob:setMod(xi.mod.PIERCE_SDT, 1500)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.HUNDRED_FISTS, hpp = 50 },
        },
    })
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    xi.apollyon_se.handleMobDeathKey(mob, player, isKiller, noKiller, 2)
end

return entity
