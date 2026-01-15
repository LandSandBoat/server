-----------------------------------
-- Area: Ship bound for Selbina Pirates
--  Mob: Enagakure
-- Involved in Quest: I'll Take the Big Box
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 600)
end

entity.onMobDeath = function(mob, player, optParams)
    if
        player:hasKeyItem(xi.ki.SEANCE_STAFF) and
        player:getCharVar('Enagakure_Killed') == 0
    then
        player:setCharVar('Enagakure_Killed', 1)
    end
end

entity.onMobDespawn = function(mob)
    mob:setLocalVar('despawnDay', VanadielUniqueDay())
end

return entity
