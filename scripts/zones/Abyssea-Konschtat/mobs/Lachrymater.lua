-----------------------------------
-- Area: Abyssea-Konschtat
--   NM: Lachrymater
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob, target)
    local DayOfTheWeek = VanadielDayOfTheWeek()

    mob:setSpellList(188 + DayOfTheWeek)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
