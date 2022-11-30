-----------------------------------
-- Area: Balga's Dais
--   NM: Medium Box
-- BCNM: Treasures and Tribulations
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

local function replaceWithCrate(mob)
    local crate = GetNPCByID(mob:getID() + 2)
    crate:teleport(mob:getPos(), mob:getRotPos())
    crate:setStatus(xi.status.NORMAL)
end

entity.onMobEngaged = function(mob, target)
    local mobId = mob:getID()
    local small = GetMobByID(mobId - 1)

    if small:getLocalVar("engaged") == 0 then
        small:setLocalVar("engaged", 1)

        mob:setMobMod(xi.mobMod.DRAW_IN, 1)
        DespawnMob(mobId - 1)
        DespawnMob(mobId + 1)

        if math.random(1, 3) == 1 then
            DespawnMob(mobId)
            replaceWithCrate(mob)
        else
            mob:setAnimationSub(1)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller then
        replaceWithCrate(mob)
    end
end

return entity
