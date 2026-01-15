-----------------------------------
-- Area: Balga's Dais
--  Mob: Goga Tlugvi (MNK) "Summer Tree"
-- BCNM: Season's Greetings
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.NO_LINK, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 7)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 7)
    mob:setMod(xi.mod.SLOW_RES_RANK, 7)
    mob:setMod(xi.mod.PARALYZE_RES_RANK, 7)
    mob:setMod(xi.mod.BIND_RES_RANK, 7)
    mob:setMod(xi.mod.BLIND_RES_RANK, 7)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setLocalVar('hundredFistsTime', 0)
end

-- If it has been more than 2 minutes since Hundred Fists was used, gain a significant damage boost.
entity.onMobFight = function(mob, target)
    if mob:getMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER) == 250 then
        return
    end

    local hundredFistsTime = mob:getLocalVar('hundredFistsTime')

    if
        hundredFistsTime > 0 and
        GetSystemTime() > hundredFistsTime + 120
    then
        mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 250)
    end
end

-- Has additional effect: Stun (15% chance)
entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN, { chance = 15, duration = math.random(7, 8) })
end

-- Only uses Leafstorm.
entity.onMobMobskillChoose = function(mob, target)
    return xi.mobSkill.LEAFSTORM
end

-- If Hundred Fists is used, the Autumn tree (Ulagohvsdi Tlugvi) attacks.
entity.onMobWeaponSkill = function(target, mob, skill)
    local skillID = skill:getID()
    local battlefield = mob:getBattlefield()

    if not battlefield then
        return
    end

    if skillID == xi.mobSkill.HUNDRED_FISTS_1 then
        local currentTime = GetSystemTime()
        mob:setLocalVar('hundredFistsTime', currentTime)
        local baseId = mob:getID()
        local autumnTree = GetMobByID(baseId + 1)

        if autumnTree and autumnTree:isAlive() then
            local currentTarget = mob:getTarget()
            if not currentTarget then
                return
            end

            autumnTree:updateEnmity(currentTarget)
        end
    end
end

return entity
