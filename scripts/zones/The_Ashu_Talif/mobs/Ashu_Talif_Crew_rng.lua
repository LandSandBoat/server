-----------------------------------
-- Area: The Ashu Talif (The Black Coffin)
--  Mob: Ashu Talif Crew (RNG)
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    -- TODO: This is a hack and should be converted to utilize a player model ranged attack state
    if skill:getID() == xi.mobSkill.RANGED_ATTACK_1 then
        mob:entityAnimationPacket(xi.animationString.RANGED_START)
        mob:timer(1000, function(mobArg)
            mobArg:entityAnimationPacket(xi.animationString.RANGED_STOP, target)
        end)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    local instance = mob:getInstance()
    if
        instance and
        (optParams.isKiller or optParams.noKiller)
    then
        instance:setProgress(instance:getProgress() + 1)
    end
end

return entity
