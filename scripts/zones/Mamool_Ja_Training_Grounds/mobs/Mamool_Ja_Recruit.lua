-----------------------------------
-- Area: Mamool Ja Training Grounds (Breaking Morale)
--  Mob: Mamool Ja Recruit
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    xi.assault.adjustMobLevel(mob)
end

entity.onMobFight = function(mob, target)
    local effect = target:getStatusEffect(xi.effect.COSTUME):getPower()

    if effect > 0 then
        mob:disengage()
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
end

return entity
