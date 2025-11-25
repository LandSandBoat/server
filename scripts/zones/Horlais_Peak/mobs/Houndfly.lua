-----------------------------------
-- Area: Horlais Peak
--  Mob: Houndfly
-- BCNM: Dropping Like Flies
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobMobskillChoose = function(mob, target)
    -- Only uses Venom
    return xi.mobSkill.VENOM_1
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
