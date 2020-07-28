-----------------------------------
-- Area: Uleguerand Range
--  MOB: White Coney
-- Note: exclusively uses Wild Carrot
-----------------------------------
local ID = require("scripts/zones/Uleguerand_Range/IDs")
-----------------------------------

--https://ffxiclopedia.fandom.com/wiki/Talk:White_Coney#Testimonials
--just a note on wild carrot beeing TP move, once when I popped I immediatly chi-blasted (w/ penance) it to lower tp gain
--but after a few hit and before pennance wore off, it used wild carrot, so:
--it pops with tp
--it uses wild carrot also start at less than 300%
--wild carrot is not tp move
--it has some kind of meditate -.-
--(based on above, going to assume it has regain...)

function onMobSpawn(mob)
    mob:setMod(tpz.mod.REGAIN, 30) -- unassisted by combat TP, will give a base of 1 wild carrot move approx every 100 sec while above 25% hp
    mob:setMod(tpz.mod.ICERES, 150)
end

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    GetNPCByID(ID.npc.RABBIT_FOOTPRINT):setLocalVar("activeTime", os.time()+math.random(60*9, 60*15))
end
