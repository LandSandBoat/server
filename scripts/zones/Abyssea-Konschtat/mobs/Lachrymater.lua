-----------------------------------
-- Area: Abyssea-Konschtat
--   NM: Lachrymater
-----------------------------------
local entity = {}

function onMobSpawn(mob ,target)
    local DayOfTheWeek = VanadielDayOfTheWeek()

    mob:setSpellList(188 + DayOfTheWeek)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
