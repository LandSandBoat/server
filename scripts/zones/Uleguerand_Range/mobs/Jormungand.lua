-----------------------------------
-- Area: Uleguerand Range
--  Mob: Jormungand
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

local function setupFlightMode(mob, battleTime)
    mob:setAnimationSub(1)
    mob:addStatusEffectEx(xi.effect.ALL_MISS, 0, 1, 0, 0)
    mob:setMobSkillAttack(732)
    mob:setLocalVar("changeTime", battleTime)
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
    -- Animation (Ground or flight mode) logic.
    if
        not mob:hasStatusEffect(xi.effect.BLOOD_WEAPON) and
        mob:actionQueueEmpty()
    then
        local changeTime  = mob:getLocalVar("changeTime")
        local twohourTime = mob:getLocalVar("twohourTime")
        local battleTime  = mob:getBattleTime()
        local animation   = mob:getAnimationSub()

        if twohourTime == 0 then
            twohourTime = math.random(8, 14)
            mob:setLocalVar("twohourTime", twohourTime)
        end

        -- Initial grounded mode.
        if
            animation == 0 and
            battleTime - changeTime > 60
        then
            setupFlightMode(mob, battleTime)

        -- Flight mode.
        elseif
            animation == 1 and
            battleTime - changeTime > 30 and
            not hasSleepEffects(mob) and mob:checkDistance(target) <= 6 -- This 2 checks are a hack until we can handle skills targeting a position and not an entity.
        then
            mob:useMobAbility(1292) -- This ability also handles animation change to 2.

            mob:setLocalVar("changeTime", battleTime)

        -- Subsequent grounded mode.
        elseif animation == 2 then
            if battleTime / 15 > twohourTime then -- 2-Hour logic.
                mob:useMobAbility(695)
                mob:setLocalVar("twohourTime", battleTime / 15 + 20)

            elseif battleTime - changeTime > 60 then -- Change mode.
                setupFlightMode(mob, battleTime)
            end
        end
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 1296 and mob:getHPP() <= 30 then
        local roarCounter = mob:getLocalVar("roarCounter")

        roarCounter = roarCounter + 1
        mob:setLocalVar("roarCounter", roarCounter)

        if roarCounter > 2 then
            mob:setLocalVar("roarCounter", 0)
        else
            mob:useMobAbility(1296)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.WORLD_SERPENT_SLAYER)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(259200, 432000)) -- 3 to 5 days
end

return entity
