-----------------------------------
-- Area: Balga's Dais
--  Mob: Opo-opo Heir
-- BCNM: Royal Succession
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
end

-- Doesn't fight until Monarch is defeated.
entity.onMobSpawn = function(mob)
    mob:setAutoAttackEnabled(false)
    mob:setMobAbilityEnabled(false)
end

entity.onMobFight = function(mob, target)
    local battlefield = mob:getBattlefield()

    if not battlefield then
        return
    end

    -- Opo-Opo Heir and Opo-Opo Monarch are meant to be killed at the same time, if Monarch dies first, Heir becomes immuned to magic and gains a significant power boost
    if
        battlefield:getLocalVar('monarchDefeated') == 1 and
        mob:getLocalVar('monarchPowerUp') == 0
    then
        mob:setLocalVar('monarchPowerUp', 1)
        mob:injectActionPacket(mob:getID(), 11, 435, 0, 0x18, 0, 0, 0)
        mob:setAutoAttackEnabled(true)
        mob:setMobAbilityEnabled(true)
        mob:addHP(mob:getMaxHP() / 2)
        mob:setTP(3000)
        mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
        mob:setMod(xi.mod.REGAIN, 300)
        mob:addStatusEffect(xi.effect.MAGIC_SHIELD, 1, 0, 900)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local battlefield = mob:getBattlefield()
        if battlefield then
            battlefield:setLocalVar('heirDefeated', 1)
        end
    end
end

return entity
