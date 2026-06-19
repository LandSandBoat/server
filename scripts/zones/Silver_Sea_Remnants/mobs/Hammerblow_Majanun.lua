-----------------------------------
-- Area: Silver Sea Remnants
--  Mob: Hammerblow Majanun
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    -- Add Salvage Event Bonus
end

entity.onMobDeath = function(mob, player, optParams)
    -- Uncomment this when salvage temp chest is ready
    -- if optParams.isKiller then
    --     local params = {}
    --     xi.salvage.spawnTempChest(mob, params)
    -- end
end

return entity
