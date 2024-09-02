-----------------------------------
-- Area: Bhaflau Remnants
--  Mob: Long-Bowed Chariot
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.COMET_CHARIOTEER)
end

return entity
