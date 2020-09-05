-----------------------------------
-- Area: Misareaux Coast
--   NM: Upyri
-----------------------------------
-- NOTES/TO DO: Tends to use weapon skills twice in a row during night time, based on retail testing.
-- There is about a 1-2 second delay, and will use the same move twice. He will rarely use a weaponskill 3 times in a row. Let's say about a 10% chance.
-- Will weapon skill normally during the day.
-- Also, may only use Soul Accretion at night.
-- Special Attacks: Hits harder at night than during the day.
-- Earring may or may not drop only if the ToD was at night.

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(75600, 86400))   -- 21 to 24 hr
end
