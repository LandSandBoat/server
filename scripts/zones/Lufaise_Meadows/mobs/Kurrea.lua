-----------------------------------
-- Area: Lufaise Meadows
--   NM: Kurrea
-- TODO: Instant cast tornado
-----------------------------------
local ID = zones[xi.zone.LUFAISE_MEADOWS]
-----------------------------------
---@type TMobEntity
local entity = {}

-- TODO: More accurate buff powers
local buffList =
{
    [ID.text.KURREA_MUSCLES] = { action = 603, animation = 432, effect = xi.effect.HASTE,           power = 25  },
    [ID.text.KURREA_SHINE  ] = { action = 604, animation = 433, effect = xi.effect.MAGIC_SHIELD,    power = 1   },
    [ID.text.KURREA_WIND   ] = { action = 624, animation = 434, effect = xi.effect.EVASION_BOOST,   power = 25  },
    [ID.text.KURREA_RIGID  ] = { action = 404, animation = 435, effect = xi.effect.DEFENSE_BOOST,   power = 25  },
    [ID.text.KURREA_VEIN   ] = { action = 625, animation = 436, effect = xi.effect.ATTACK_BOOST,    power = 25  },
    [ID.text.KURREA_EYES   ] = { action = 626, animation = 437, effect = xi.effect.MAGIC_ATK_BOOST, power = 25  },
    [ID.text.KURREA_CURE   ] = { action = 627, animation = 438, effect = xi.effect.NONE,            power = 25  },
    [ID.text.KURREA_AURA   ] = { action = 307, animation = 439, effect = xi.effect.PHYSICAL_SHIELD, power = 1   },
    [ID.text.KURREA_GREEN  ] = { action =   0, animation =   0, effect = xi.effect.DEFENSE_DOWN,    power = 25  },
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 120)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGEN, 50)
    mob:setLocalVar('buffTimer', GetSystemTime() + math.random(30, 40))
end

entity.onMobFight = function(mob, target)
    local buffTimer = mob:getLocalVar('buffTimer')
    local pathingToSpawn = mob:getLocalVar('pathingToSpawn')

    if
        GetSystemTime() >= buffTimer and
        pathingToSpawn == 0 and
        not xi.combat.behavior.isEntityBusy(mob)
    then
        mob:setMagicCastingEnabled(false)
        mob:setMobAbilityEnabled(false)
        mob:setAutoAttackEnabled(false)
        mob:pathTo(-249.320, -16.189, 41.497) -- Spawn QM location
        mob:setLocalVar('pathingToSpawn', 1)
        return
    end

    if pathingToSpawn == 1 and not mob:isFollowingPath() then
        local buffChoice = math.random(ID.text.KURREA_MUSCLES, ID.text.KURREA_GREEN)
        local timer      = math.random(30, 40)
        mob:setLocalVar('pathingToSpawn', 0)
        mob:setLocalVar('buffTimer', GetSystemTime() + timer)
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)

        -- Play 2hr dust cloud animation unless its KURREA_GREEN
        if buffList[buffChoice] ~= ID.text.KURREA_GREEN then
            mob:injectActionPacket(mob:getID(), 11, buffList[buffChoice].animation, 0x18, 0, 0, buffList[buffChoice].action, 0)
        end

        -- Heal Kurrea, or apply buff/debuff
        if buffList[buffChoice].effect == xi.effect.NONE then
            mob:addHP(mob:getMaxHP() * .25)
        else
            mob:addStatusEffectEx(buffList[buffChoice].effect, buffList[buffChoice].effect, buffList[buffChoice].power, 0, timer, true)
        end

        mob:messageText(mob, ID.text.KURREA_SLURP, false)
        mob:messageText(mob, buffChoice, false)

        mob:timer(3000, function(mobArg)
            mobArg:setMobMod(xi.mobMod.NO_MOVE, 0)
            mobArg:setMagicCastingEnabled(true)
            mobArg:setMobAbilityEnabled(true)
            mobArg:setAutoAttackEnabled(true)
        end)
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.TORNADO,
        xi.magic.spell.AEROGA_III,
        xi.magic.spell.AERO_IV,
        xi.magic.spell.GRAVIGA,
        xi.magic.spell.SILENCEGA,
    }
    return spellList[math.random(1, #spellList)]
end

return entity
