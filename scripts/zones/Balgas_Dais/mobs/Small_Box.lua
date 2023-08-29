-----------------------------------
-- Area: Balga's Dais
--   NM: Small Box
-- BCNM: Treasures and Tribulations
-----------------------------------
local entity = {}

local function replaceWithCrate(mob)
    local crate = GetNPCByID(mob:getID() + 3)
    crate:teleport(mob:getPos(), mob:getRotPos())
    crate:setStatus(xi.status.NORMAL)
end

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.ATTP, -25)
    mob:setMod(xi.mod.DEFP, -25)
    mob:setMod(xi.mod.EVA, 50)
end

entity.onMobEngaged = function(mob, target)
    local mobId = mob:getID()

    if mob:getLocalVar('engaged') == 0 then
        mob:setLocalVar('engaged', 1)

        mob:setMobMod(xi.mobMod.DRAW_IN, 1)
        DespawnMob(mobId + 1)
        DespawnMob(mobId + 2)

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
