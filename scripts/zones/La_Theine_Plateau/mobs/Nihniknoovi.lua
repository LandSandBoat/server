-----------------------------------
-- Area: La Theine Plateau
--  Mob: Nihniknoovi
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
require("scripts/quests/tutorial")
-----------------------------------

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 600)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 153)
    tpz.tutorial.onMobDeath(player)
end
