-----------------------------------
-- Area: RaKaznar_Inner_Court
--  Mob: Poxhound
-- ERA Custom NM
-----------------------------------
local entity = {}

-- HP% thresholds at which phase abilities are used
local phaseAbilities =
{
    { hpp = 80, skillId = xi.mobSkill.PETRIBREATH, varState = 1 },
    { hpp = 55, skillId = xi.mobSkill.PETRIBREATH, varState = 2 },
    { hpp = 30, skillId = xi.mobSkill.PETRIBREATH, varState = 3 },
    { hpp = 10, skillId = xi.mobSkill.PETRIBREATH, varState = 4 },
}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.BINDRES,       20)
    mob:setMod(xi.mod.SLEEPRES,      100)
    mob:setMod(xi.mod.MDEF,          50)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 30)
end

entity.onMobEngaged = function(mob, target)
    mob:setMod(xi.mod.REGAIN, 250)
end

entity.onMobFight = function(mob, target)
    local hpp        = mob:getHPP()
    local phaseState = mob:getLocalVar('PhaseState')

    if hpp == 100 then
        mob:setLocalVar('PhaseState', 0)
        return
    end

    for _, phase in ipairs(phaseAbilities) do
        if hpp < phase.hpp and phaseState == phase.varState - 1 then
            mob:setLocalVar('PhaseState', phase.varState)
            mob:resetEnmity(target)
            mob:useMobAbility(phase.skillId)
            return
        end
    end
end

entity.onMobDisengage = function(mob)
    mob:setMod(xi.mod.REGAIN, 0)
end

entity.onMobDespawn = function(mob)
end

return entity
