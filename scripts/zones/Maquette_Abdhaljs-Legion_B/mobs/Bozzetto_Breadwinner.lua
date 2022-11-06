-----------------------------------
-- Bozzetto Breadwinner (Meeble)
-- https://ffxiclopedia.fandom.com/wiki/Ambuscade/Battlefield_Archive/Bozzetto_Breadwinner
--
-- Will Warble approximately once every 30 seconds.
-- Every Warble move has roughly 2 seconds of readying time on Very Easy,
-- shortening as the difficulty setting rises.
-- Warbles have a chance to summon Urchins and activate the Housemaker,
-- and will wake any nearby Urchins. Inflicting Silence on the Breadwinner
-- may (but not reliably so) prevent Warbles from summoning Urchins or
-- activating the Housemaker.[3].
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

local doWarble
doWarble = function(mob)
    -- 3968 -- fire_meeble_warble
    -- 3969 -- blizzard_meeble_warble
    -- 3970 -- thunder_meeble_warble
    -- 3971 -- stone_meeble_warble
    -- 3972 -- water_meeble_warble
    -- 3973 -- aero_meeble_warble
    if mob:isEngaged() then
        local randomOffset = math.random(0, 5)
        mob:useMobAbility(3968 + randomOffset)

        -- Again in 30s
        mob:timer(30000, function(mobArg)
            doWarble(mobArg)
        end)
    end
end

entity.onMobInitialize = function(mob)
    -- Clod Spikes: Become active during Hundred Fists. Deals earth damage and inflicts a potent
    -- Slow effect on any player who physically strikes the Breadwinner.
    -- The Slow effect is strong enough to overwite Haste II.
    mob:addListener("TAKE_DAMAGE", "BREADWINNDER_TAKE_DAMAGE", function(mobArg, amount, attacker, attackType, damageType)
        if mobArg:hasStatusEffect(xi.effect.HUNDRED_FISTS) then
            attacker:addStatusEffect(xi.effect.SLOW, 30 * 100, 0, 60)
        end
    end)
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.HUNDRED_FISTS, hpp = 50, duration = 45 },
        },
    })
end

entity.onMobEngaged = function(mob, target)
    -- After 30s, start warbling
    mob:timer(30000, function(mobArg)
        doWarble(mobArg)
    end)
end

entity.onMobFight = function(mob, target)
end

entity.onMobWeaponSkill = function(target, mob, skill)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
