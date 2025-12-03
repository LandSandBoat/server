-----------------------------------
-- Area: Mine Shaft 2716
-- CoP Mission 5-3 (A Century of Hardship)
-- NM: Movamuq
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, 50)
    mob:setMobAbilityEnabled(false)
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    local hpTripper = mob:getLocalVar('hpTripper')
    if
        (mob:getHPP() <= 50 and hpTripper == 0) or
        (mob:getHPP() <= 25 and hpTripper == 1)
    then
        mob:setLocalVar('hpTripper', hpTripper + 1)
        battlefield:setLocalVar('triggerMoblinCommand', mob:getID())
    end
end

entity.onMobMobskillChoose = function(mob, target)
    return xi.mobSkill.FRYPAN_1
end

return entity
