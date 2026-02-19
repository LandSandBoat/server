-----------------------------------
-- Area: Newton Movalpolos
--   NM: Goblin Collector
-----------------------------------
local ID = zones[xi.zone.NEWTON_MOVALPOLOS]
-----------------------------------

local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GIL_MIN, 18000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 18000)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.POWER_MULTIPLIER_SPELL, 100)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 20)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 450)
    mob:setMod(xi.mod.ATT, 425)
    mob:showText(mob, ID.text.COLLECTOR_SPAWN, xi.item.PREMIUM_BAG)
end

entity.onMobEngage = function(mob, target)
    mob:stun(3000)
    mob:timer(1000, function(mobArg)
        mob:injectActionPacket(mob:getID(), 11, 995, 0, 0x18, 0, 0, 1344, 0)
    end)
end

entity.onMobFight = function(mob, target)
    -- Resets threat on every auto attack
    mob:addListener('ATTACK', 'COLLECTOR_ATTACK', function(goblin)
        goblin:resetEnmity(target)
    end)
end

entity.onMobDeath = function(mob, player, optParams)
    mob:removeListener('COLLECTOR_ATTACK')
end

return entity
