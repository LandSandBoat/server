-----------------------------------
-- Area: Bhaflau Thickets
--   NM: Emergent Elm
-- !pos 71.000 -33.000 627.000 52
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.BIND)
end

entity.onMobFight = function(mob, target)
    local currentTime = VanadielHour()

    if currentTime >= 6 and currentTime <= 18 then
        mob:setMod(xi.mod.REGEN, 150) -- Exact amount requires confirmation
    else
        mob:setMod(xi.mod.REGEN, 0)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 452)
end

return entity
