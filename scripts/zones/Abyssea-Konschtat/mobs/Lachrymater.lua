-----------------------------------
-- Area: Abyssea-Konschtat
--   NM: Lachrymater
-----------------------------------

function onMobSpawn(mob,target)
    local DayofWeek = VanadielDayOfWeek()

    mob:setSpellList(188 + DayofWeek)
end

function onMobDeath(mob, player, isKiller)
end
