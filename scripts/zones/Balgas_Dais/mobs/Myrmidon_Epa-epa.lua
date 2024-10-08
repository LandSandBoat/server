-----------------------------------
-- Area: Balga's Dais
--  Mob: Myrmidon Epa-epa
-- BCNM: Royal Succession
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.SLEEP_MEVA, 50)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
