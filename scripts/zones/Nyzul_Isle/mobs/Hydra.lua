-----------------------------------
--  MOB: Hydra
-- Area: Nyzul Isle
-- Info: Floor 60 80 and 100 Boss
-----------------------------------
mixins = { require('scripts/mixins/nyzul_boss_drops') }
-----------------------------------
local entity = {}

local function handleRegen(mob, broken)
    local multiplier = (2 - broken) * 0.75
    mob:setMod(xi.mod.REGEN, math.floor(25 * multiplier))
    mob:setMod(xi.mod.REGAIN, math.floor(25 * multiplier))
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.UDMGMAGIC, -90)
    mob:setMod(xi.mod.POISON_MEVA, 100)
    mob:setMod(xi.mod.BLIND_MEVA, 100)
    -- mob:addImmunity(xi.immunity.BIND)
    -- mob:addImmunity(xi.immunity.GRAVITY)
    -- mob:addImmunity(xi.immunity.PARALYZE)
    -- mob:addImmunity(xi.immunity.TERROR)
    mob:setMod(xi.mod.SILENCE_MEVA, 100)
    mob:setMod(xi.mod.SLOW_MEVA, 100)
    mob:setMod(xi.mod.STUN_MEVA, 175)
    mob:setMod(xi.mod.SLEEP_MEVA, 150)
    mob:setMod(xi.mod.DEFP, 35)
    mob:addMod(xi.mod.EVA, 15)
    mob:setMod(xi.mod.MAIN_DMG_RATING, 40)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 15)
end

entity.onMobEngaged = function(mob)
    handleRegen(mob, mob:getAnimationSub())
end

entity.onMobFight = function(mob, target)
    local battletime = os.time()
    local headgrow   = mob:getLocalVar('headgrow')
    local broken     = mob:getAnimationSub()

    if headgrow < battletime and broken > 0 then
        mob:setAnimationSub(broken - 1)
        mob:setLocalVar('headgrow', battletime + 300)
        mob:setTP(3000)
        handleRegen(mob, broken - 1)
    end
end

entity.onCriticalHit = function(mob)
    local rand   = math.random(1, 100)
    local broken = mob:getAnimationSub()

    if rand <= 15 and broken < 2 then
        mob:setAnimationSub(broken + 1)
        mob:setLocalVar('headgrow', os.time() + math.random(120, 240))
        handleRegen(mob, broken + 1)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.nyzul.enemyLeaderKill(mob)
        xi.nyzul.vigilWeaponDrop(player, mob)
        xi.nyzul.handleRunicKey(mob)
    end
end

return entity
