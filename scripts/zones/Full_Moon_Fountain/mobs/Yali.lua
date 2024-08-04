-----------------------------------
-- Area: Full Moon Fountain
--  Mob: Yali
-- Windurst Mission 9-2
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setSpellList(135)
end

entity.onMobSpawn = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
