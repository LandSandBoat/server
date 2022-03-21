-----------------------------------
--  MOB: Hydra
-- Area: Nyzul Isle
-- Info: Floor 60 80 and 100 Boss
-----------------------------------
mixins = { require("scripts/mixins/nyzul_boss_drops") }
require("scripts/globals/utils/nyzul")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.UDMGMAGIC, -90)
    mob:setMod(xi.mod.POISONRES, 100)
    mob:setMod(xi.mod.BLINDRES, 100)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:setMod(xi.mod.SILENCERES, 100)
    mob:setMod(xi.mod.SLOWRES, 100)
    mob:setMod(xi.mod.STUNRES, 175)
    mob:setMod(xi.mod.SLEEPRES_LIGHT, 150)
    mob:setMod(xi.mod.SLEEPRES_DARK, 150)
    mob:setMod(xi.mod.DEFP, 35)
    mob:addMod(xi.mod.EVA, 15)
    mob:setMod(xi.mod.MAIN_DMG_RATING, 40)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 15)
end

function handleRegen(mob, broken)
    local multiplier = (2 - broken) / 2
    mob:setMod(xi.mod.REGEN, math.floor(100 * multiplier))
    mob:setMod(xi.mod.REGAIN, math.floor(200 * multiplier))
end

function onMobEngaged(mob)
    handleRegen(mob, mob:AnimationSub())
end

function onMobFight(mob, target)
    local battletime = os.time()
    local headgrow = mob:getLocalVar("headgrow")
    local broken = mob:AnimationSub()

    if headgrow < battletime and broken > 0 then
        mob:AnimationSub(broken - 1)
        mob:setLocalVar("headgrow", battletime + 300)
        mob:setTP(3000)
        handleRegen(mob, broken - 1)
    end

end

function onCriticalHit(mob)
    local rand = math.random(1, 100)
    local battletime = os.time()
    local headgrow = mob:getLocalVar("headgrow")
    local broken = mob:AnimationSub()

    if rand <= 15 and broken < 2 then
        mob:AnimationSub(broken + 1)
        mob:setLocalVar("headgrow", os.time() + math.random(120, 240))
        handleRegen(mob, broken + 1)
    end

end

function onMobDeath(mob, player, isKiller, firstCall)
    if firstCall then
        nyzul.enemyLeaderKill(mob)
        nyzul.vigilWeaponDrop(player, mob)
        nyzul.handleRunicKey(mob)
    end
end
