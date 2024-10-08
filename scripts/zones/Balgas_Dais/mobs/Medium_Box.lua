-----------------------------------
-- Area: Balga's Dais
--   NM: Medium Box
-- BCNM: Treasures and Tribulations
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobEngage = function(mob, target)
    local mobId = mob:getID()
    local small = GetMobByID(mobId - 1)

    if
        small and
        small:getLocalVar('engaged') == 0
    then
        small:setLocalVar('engaged', 1)

        mob:setMobMod(xi.mobMod.DRAW_IN, 1)
        DespawnMob(mobId - 1)
        DespawnMob(mobId + 1)

        if math.random(1, 3) == 1 then
            mob:setStatus(xi.status.INVISIBLE)
            mob:setHP(0)
        else
            mob:setAnimationSub(1)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
