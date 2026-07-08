-----------------------------------
-- Area: Ve'Lugannon Palace
--  Mob: Caretaker
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 743, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 746, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    local master = GetMobByID(mob:getID() - 1)
    if master and master:isSpawned() then
        master:setLocalVar('petRespawn', GetSystemTime() + 10)
    end
end

return entity
