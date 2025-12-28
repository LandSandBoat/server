-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Genbu (Pet version)
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.COUNTER, 20)
    mob:setLocalVar('defaultATT', mob:getMod(xi.mod.ATT))
end

entity.onMobFight = function(mob, target)
    -- Gains +5 attack per 1% HP lost
    local hp = mob:getHPP()
    local power = (100 - hp) * 5

    mob:setMod(xi.mod.ATT, mob:getLocalVar('defaultATT') + power)

    -- Gains regain below 50%
    if mob:getHPP() < 50 then
        mob:setMod(xi.mod.REGAIN, 80)
    else
        mob:setMod(xi.mod.REGAIN, 0)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENWATER)
end

return entity
