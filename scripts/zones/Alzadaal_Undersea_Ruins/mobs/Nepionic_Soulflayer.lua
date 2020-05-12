-----------------------------------
-- Area: Alzadaal Undersea Ruins (72)
--  Mob: Nepionic Soulflayer
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

--TODO: Immortal Shield - Magic Shield (Only prevents direct damage from spells)
--TODO: Immortal Mind - Magic Atk Boost

function onMobInitialize(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

function onMobDeath(mob, player, isKiller)
    if player:getCharVar("TransformationsProgress") == 4 then
        player:setCharVar("TransformationsProgress", 5)
    end
end
