-----------------------------------
-- Area: Full Moon Fountain
-- Mob: Ramuh Prime
-- Quest: Waking the Beast
-- Note: most of the logic for this mob (such as spawning and 2hr) is handled
-- in the full moon fountain waking_the_beast battlefield file
-----------------------------------
local ID = zones[xi.zone.FULL_MOON_FOUNTAIN]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.UDMGPHYS, -6000)
    mob:setMod(xi.mod.UDMGRANGE, -6000)
    mob:setMod(xi.mod.UDMGMAGIC, -2000)
    mob:setMod(xi.mod.LTNG_ABSORB, 100)
    -- do not need to set res rank for thunder because WTB primes have own
    -- mob resistances row that sets it already
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    -- element specific immunities
    mob:addImmunity(xi.immunity.POISON)
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:showText(mob, ID.text.TAINTED_JUSTICE)
    end

    if mob:getLocalVar('onDeathCalled') == 0 then
        mob:setLocalVar('onDeathCalled', 1)
        -- set some local variables useful in determining the phases of the fight
        mob:setLocalVar('wasDefeated', 1)
        local battlefield = mob:getBattlefield()
        if battlefield then
            battlefield:setLocalVar('avatarsDefeated', battlefield:getLocalVar('avatarsDefeated') + 1)
        end
    end
end

return entity
