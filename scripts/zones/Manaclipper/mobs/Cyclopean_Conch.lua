-----------------------------------
-- Area: Manaclipper
--   NM: Cyclopean Conch
-----------------------------------
mixins = { require("scripts/mixins/families/uragnite") }
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:getLocalVar("respawn", os.time() + 43200) -- 12 hour respawn
end

return entity
