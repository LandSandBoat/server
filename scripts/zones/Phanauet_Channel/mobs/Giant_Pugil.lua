-----------------------------------
-- Area: Phanauet Channel (1)
--  Mob: Giant Pugil
-----------------------------------
---@type TMobEntity
local entity = {}

-- Barge mobs spawn and despawn on their own, without ever being killed based on captures.
-- The barge ride rolls a chance to spawn each one (see the zone script); once up it stays for
-- a few minutes then despawns. Scripted spawn, so he does not return until the next roll.
-- The time frames for this were based on an average using many captures.
entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, math.randomInt(180, 540)) -- Despawns after 3 to 9 minutes.
end

return entity
