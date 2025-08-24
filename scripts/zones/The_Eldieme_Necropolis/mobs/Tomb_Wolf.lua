-----------------------------------
-- Area: The Eldieme Necropolis
--  Mob: Tomb Wolf
-- Note: PH for Cwn Cyrff
-----------------------------------
local ID = zones[xi.zone.THE_ELDIEME_NECROPOLIS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 675, 1, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.CWN_CYRFF, 5, 3600) -- 1-4 hours
end

return entity
