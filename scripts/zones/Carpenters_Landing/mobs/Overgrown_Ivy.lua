-----------------------------------
-- Area: Carpenters_Landing
--  Mob: Overgrown Ivy
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:addMod(xi.mod.REGAIN, 50)
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() <= 15 then
        mob:setMod(xi.mod.REGAIN, 200)
    end

    -- Capture shows Ivy uses 5x bad breath when it falls below 20% then resumes normal attacks and TP moves
    local badBreaths = mob:getLocalVar("badBreaths")

    if mob:getCurrentAction() == xi.act.ATTACK then
        if badBreaths == 0 and mob:getHPP() <= 20 then
            mob:useMobAbility(319)
            mob:setLocalVar("badBreaths", badBreaths + 1)
        elseif badBreaths == 1 and mob:getHPP() <= 20 then
            mob:useMobAbility(319)
            mob:setLocalVar("badBreaths", badBreaths + 1)
        elseif badBreaths == 2 and mob:getHPP() <= 20 then
            mob:useMobAbility(319)
            mob:setLocalVar("badBreaths", badBreaths + 1)
        elseif badBreaths == 3 and mob:getHPP() <= 20 then
            mob:useMobAbility(319)
            mob:setLocalVar("badBreaths", badBreaths + 1)
        elseif badBreaths == 4 and mob:getHPP() <= 20 then
            mob:setLocalVar("badBreaths", badBreaths + 1)
            mob:useMobAbility(319)
        end
    end
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    if mob:getHPP() <= 15 then
        return 319 -- bad_breathe
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
