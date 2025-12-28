-----------------------------------
-- Area: Bhaflau Thickets
--  Mob: Olden Treant
-- Note: Place holder Emergent Elm
-----------------------------------
local ID = zones[xi.zone.BHAFLAU_THICKETS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.EMERGENT_ELM, 5, 7200) -- 2 hours
end

return entity
