-----------------------------------
-- Area: Balga's Dais
--  Mob: Opo-opo Monarch
-- BCNM: Royal Succession
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 60)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
end

entity.onMobFight = function(mob, target)
    local battlefield = mob:getBattlefield()

    if not battlefield then
        return
    end

    local myrmidonDefeated = battlefield:getLocalVar('myrmidonDefeated')
    local myrmidonPowerUps = mob:getLocalVar('myrmidonPowerUps')

    -- When a Myrmidon is defeated, gain a small attack boost
    if myrmidonDefeated > myrmidonPowerUps then
        mob:setLocalVar('myrmidonPowerUps', myrmidonDefeated)
        mob:injectActionPacket(mob:getID(), 11, 435, 0, 0x18, 0, 0, 0)
        mob:addMod(xi.mod.ATT, 15)
    end

    -- Opo-Opo Heir and Opo-Opo Monarch are meant to be killed at the same time, if Heir dies first, Monarch becomes immune to physical damage and gains a significant power boost
    if
        battlefield:getLocalVar('heirDefeated') == 1 and
        mob:getLocalVar('heirPowerUp') == 0
    then
        mob:setLocalVar('heirPowerUp', 1)
        mob:injectActionPacket(mob:getID(), 11, 435, 0, 0x18, 0, 0, 0)
        mob:addHP(mob:getMaxHP() / 2)
        mob:setTP(3000)
        mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
        mob:setMod(xi.mod.REGAIN, 300)
        mob:addMod(xi.mod.UDMGPHYS, -10000)
        mob:addMod(xi.mod.UDMGRANGE, -10000)
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.HASTEGA,
        xi.magic.spell.SLOWGA,
        xi.magic.spell.STONEGA,
        xi.magic.spell.ABSORB_MND,
    }

    return spellList[math.random(1, #spellList)]
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local battlefield = mob:getBattlefield()
        if battlefield then
            battlefield:setLocalVar('monarchDefeated', 1)
        end
    end
end

return entity
