-----------------------------------
-- Area: Den of Rancor
--  Mob: Hakutaku
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 1600)
    mob:setMobMod(xi.mobMod.GIL_MAX, 3500)
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
    mob:setMod(xi.mod.TRIPLE_ATTACK, 45)
>>>>>>> 2232eb8309 (Adding Hakutaku)
=======
>>>>>>> 1f3161638a (Hakutaku)
=======
>>>>>>> d89bd8e0c7f96ba5ea55d287d53186d48382f052
end

entity.onMobDeath = function(mob, player, isKiller)
end

<<<<<<< HEAD
<<<<<<< HEAD
return entity
=======
return entity
>>>>>>> 2232eb8309 (Adding Hakutaku)
=======
return entity
>>>>>>> 3441da6dfa (Update Hakutaku.lua)
