-----------------------------------
-- Area: Lebros Cavern
--  Mob: Crimson Eruca
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- TODO: Handle resists
	-- mob:addResist({ xi.resist.ENFEEBLING_LIGHTSLEEP, 25, 0 })
    -- mob:addResist({ xi.resist.ENFEEBLING_DARKSLEEP, 25, 0 })
    -- mob:addResist({ xi.resist.ENFEEBLING_GRAVITY, 25, 0 })
    -- mob:addResist({ xi.resist.ENFEEBLING_BIND, 25, 0 })
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
