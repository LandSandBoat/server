-----------------------------------
-- Area: Balga's Dais
--   NM: Small Box
-- BCNM: Treasures and Tribulations
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

function replaceWithCrate(mob)
    local crate = GetNPCByID(mob:getID() + 3)
    crate:teleport(mob:getPos(), mob:getRotPos())
    crate:setStatus(tpz.status.NORMAL)
end

entity.onMobInitialize = function(mob)
    mob:setMod(tpz.mod.ATTP, -25)
    mob:setMod(tpz.mod.DEFP, -25)
    mob:setMod(tpz.mod.EVA, 50)
end

function onMobEngaged(mob, target)
    local mobId = mob:getID()

    if mob:getLocalVar("engaged") == 0 then
        mob:setLocalVar("engaged", 1)

        mob:setMobMod(tpz.mobMod.DRAW_IN, 1)
        DespawnMob(mobId + 1)
        DespawnMob(mobId + 2)

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

return entity
