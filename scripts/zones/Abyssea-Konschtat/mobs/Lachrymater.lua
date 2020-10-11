-----------------------------------
-- Area: Abyssea-Konschtat
--   NM: Lachrymater
-----------------------------------

function onMobSpawn(mob ,target)
    local DayOfTheWeek = VanadielDayOfTheWeek()

    mob:setSpellList(188 + DayOfTheWeek)
end

function onMobDeath(mob, player, isKiller)
end
