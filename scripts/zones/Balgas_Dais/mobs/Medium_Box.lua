-----------------------------------
-- Area: Balga's Dais
--   NM: Medium Box
-- BCNM: Treasures and Tribulations
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function replaceWithCrate(mob)
    local crate = GetNPCByID(mob:getID() + 2)
    crate:teleport(mob:getPos(), mob:getRotPos())
    crate:setStatus(tpz.status.NORMAL)
end

function onMobEngaged (mob, target)
    local mobId = mob:getID()
    local small = GetMobByID(mobId - 1)

    if small:getLocalVar("engaged") == 0 then
        small:setLocalVar("engaged", 1)

        mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
        DespawnMob(mobId - 1)
        DespawnMob(mobId + 1)

        if math.random(3) == 1 then
            DespawnMob(mobId)
            replaceWithCrate(mob)
        else
            mob:setAnimationSub(1)
        end
    end
end

function onMobDeath(mob, player, isKiller)
    if isKiller then
        replaceWithCrate(mob)
    end
end
