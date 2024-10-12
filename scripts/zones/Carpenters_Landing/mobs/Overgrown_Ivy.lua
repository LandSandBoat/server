-----------------------------------
-- Area: Carpenters_Landing
--  Mob: Overgrown Ivy
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobFight = function(mob, target)
    -- retail capture shows mob using 5x bad breath when it falls below 20%
    -- then resumes normal attacks and moves
    local badBreaths = mob:getLocalVar('badBreaths')
    -- also check to make sure that mob is not currently using a bad breath
    if
        mob:getCurrentAction() == xi.act.ATTACK and
        badBreaths < 5 and
        mob:getHPP() <= 25
    then
        mob:useMobAbility(319)
        mob:setLocalVar('badBreaths', badBreaths + 1)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
