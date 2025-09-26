-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Aura Gear
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 749, 1, xi.regime.type.GROUNDS)
    xi.regime.checkRegime(player, mob, 752, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    local master = GetMobByID(mob:getID() - 1)
    if master and master:isSpawned() then
        master:setLocalVar('petRespawn', GetSystemTime() + 10)
    end
end

return entity
