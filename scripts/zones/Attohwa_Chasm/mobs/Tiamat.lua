-----------------------------------
-- Area: Attohwa Chasm
--  Mob: Tiamat
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

local function setupFlightMode(mob, battleTime, mobHP)
    mob:setAnimationSub(1) -- Change to flight.
    mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
    mob:setMobSkillAttack(730)
    mob:setLocalVar("changeTime", battleTime)
    mob:setLocalVar("changeHP", mobHP / 1000)
end

entity.onMobInitialize = function(mob)
    mob:setCarefulPathing(true)
end

entity.onMobSpawn = function(mob)
    -- Reset animation so it starts grounded.
    mob:setMobSkillAttack(0)
    mob:setAnimationSub(0)
end

entity.onMobFight = function(mob, target)
    -- Gains a large attack boost when health is under 25% which cannot be Dispelled.
    if
        mob:getHPP() <= 25 and
        not mob:hasStatusEffect(xi.effect.ATTACK_BOOST)
    then
        mob:addStatusEffect(xi.effect.ATTACK_BOOST, 75, 0, 0)
        mob:getStatusEffect(xi.effect.ATTACK_BOOST):setFlag(xi.effectFlag.DEATH)
    end

    -- Animation (Ground or flight mode) logic.
    if
        not mob:hasStatusEffect(xi.effect.MIGHTY_STRIKES) and
        mob:actionQueueEmpty()
    then
        local changeTime  = mob:getLocalVar("changeTime")
        local twohourTime = mob:getLocalVar("twohourTime")
        local changeHP    = mob:getLocalVar("changeHP")
        local battleTime  = mob:getBattleTime()
        local animation   = mob:getAnimationSub()
        local mobHP       = mob:getHP()

        if twohourTime == 0 then
            twohourTime = math.random(8, 14)
            mob:setLocalVar("twohourTime", twohourTime)
        end

        -- Initial grounded mode.
        if
            animation == 0 and
            battleTime - changeTime > 60
        then
            setupFlightMode(mob, battleTime, mobHP)

        -- Flight mode.
        elseif
            animation == 1 and
            (mobHP / 1000 <= changeHP - 10 or battleTime - changeTime > 120) and
            not hasSleepEffects(mob) and mob:checkDistance(target) <= 6 -- This 2 checks are a hack until we can handle skills targeting a position and not an entity.
        then
            mob:useMobAbility(1282) -- This ability also handles animation change to 2.

            mob:setLocalVar("changeTime", battleTime)
            mob:setLocalVar("changeHP", mobHP / 1000)

        -- Subsequent grounded mode.
        elseif animation == 2 then
            if battleTime / 15 > twohourTime then -- 2-Hour logic.
                mob:useMobAbility(688)
                mob:setLocalVar("twohourTime", battleTime / 15 + math.random(4, 8))

            elseif mobHP / 1000 <= changeHP - 10 or battleTime - changeTime > 120 then -- Change mode.
                setupFlightMode(mob, battleTime, mobHP)
            end
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.TIAMAT_TROUNCER)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(259200, 432000)) -- 3 to 5 days
end

return entity
