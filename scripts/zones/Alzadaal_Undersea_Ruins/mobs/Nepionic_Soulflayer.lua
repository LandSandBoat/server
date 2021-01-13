-----------------------------------
-- Area: Alzadaal Undersea Ruins (72)
--  Mob: Nepionic Soulflayer
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}
--TODO: Immortal Shield - Magic Shield (Only prevents direct damage from spells)
--TODO: Immortal Mind - Magic Atk Boost

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, isKiller)
    if player:getCharVar("TransformationsProgress") == 4 then
        player:setCharVar("TransformationsProgress", 5)
    end
end

return entity
