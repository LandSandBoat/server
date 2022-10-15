-----------------------------------
-- Area: Konschtat Highlands
--   NM: Bendigeit Vran
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobs")
require("scripts/quests/tutorial")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobRoam = function(mob)
    local hour = VanadielHour()
    if hour >= 5 and hour < 17 then
        DespawnMob(mob:getID())
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.EVA_DOWN)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.tutorial.onMobDeath(player)
end

entity.onMobDespawn = function(mob)
    mob:setLocalVar("cooldown", os.time() + (144 * 13)) -- 13 vanadiel hours guarantees it will not spawn twice in the same night
end

return entity
