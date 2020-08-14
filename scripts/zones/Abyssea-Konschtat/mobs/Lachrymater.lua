-----------------------------------
-- Area: Abyssea-Konschtat
--   NM: Lachrymater
-----------------------------------

function onMobSpawn(mob, target)
    local DayofWeek = VanadielDayElement()

    mob:setSpellList(188 + DayofWeek)
end

function onMobDeath(mob, player, isKiller)
end
