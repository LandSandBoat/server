-----------------------------------
-- Area: Abyssea-Konschtat
--   NM: Lachrymater
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    local DayOfTheWeek = VanadielDayOfTheWeek()

    mob:setSpellList(188 + DayOfTheWeek)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
