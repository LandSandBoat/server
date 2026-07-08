-----------------------------------
-- Area: Korroloka Tunnel (173)
--  Mob: Huge Spider
-- Note: PH for Falcatus Aranei
-----------------------------------
local ID = zones[xi.zone.KORROLOKA_TUNNEL]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 729, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.FALCATUS_ARANEI, 5, 7200) -- 2 hour minimum
end

return entity
