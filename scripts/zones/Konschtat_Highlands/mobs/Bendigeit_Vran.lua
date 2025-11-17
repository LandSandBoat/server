-----------------------------------
-- Area: Konschtat Highlands
--   NM: Bendigeit Vran
-----------------------------------
require('scripts/quests/tutorial')
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobRoam = function(mob)
    local hour = VanadielHour()
    local phase = VanadielMoonPhase()
    if
        (hour >= 5 and hour < 17) or
        phase > 10
    then
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
    mob:setLocalVar('cooldown', GetSystemTime() + (144 * 13)) -- 13 vanadiel hours guarantees it will not spawn twice in the same night
end

return entity
