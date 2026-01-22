-----------------------------------
-- Area: Empyreal Paradox
--  Mob: Promathia
-- Note: Phase 1
-----------------------------------
local ID = zones[xi.zone.EMPYREAL_PARADOX]
-----------------------------------
---@type TMobEntity
local entity = {}

local raceToChains =
{
    [xi.race.HUME_M  ] = { skill = xi.mobSkill.CHAINS_OF_APATHY,    message = ID.text.PROMATHIA_TEXT     },
    [xi.race.HUME_F  ] = { skill = xi.mobSkill.CHAINS_OF_APATHY,    message = ID.text.PROMATHIA_TEXT     },
    [xi.race.ELVAAN_M] = { skill = xi.mobSkill.CHAINS_OF_ARROGANCE, message = ID.text.PROMATHIA_TEXT + 1 },
    [xi.race.ELVAAN_F] = { skill = xi.mobSkill.CHAINS_OF_ARROGANCE, message = ID.text.PROMATHIA_TEXT + 1 },
    [xi.race.TARU_M  ] = { skill = xi.mobSkill.CHAINS_OF_COWARDICE, message = ID.text.PROMATHIA_TEXT + 2 },
    [xi.race.TARU_F  ] = { skill = xi.mobSkill.CHAINS_OF_COWARDICE, message = ID.text.PROMATHIA_TEXT + 2 },
    [xi.race.GALKA   ] = { skill = xi.mobSkill.CHAINS_OF_RAGE,      message = ID.text.PROMATHIA_TEXT + 3 },
    [xi.race.MITHRA  ] = { skill = xi.mobSkill.CHAINS_OF_ENVY,      message = ID.text.PROMATHIA_TEXT + 4 },
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.STUN)
    mob:setMod(xi.mod.REGAIN, 75)
    mob:setMod(xi.mod.UFASTCAST, 50)
    mob:setMod(xi.mod.DESPAWN_TIME_REDUCTION, 10)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 15)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 15)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('nextBreakpoint', 90)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 250)
    mob:setMod(xi.mod.DEF, 250)
    mob:setMod(xi.mod.MDEF, 30)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 25)
end

entity.onMobFight = function(mob, target)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    -- Trigger Prishe reaction on first instance of damage done to Promathia
    if
        mob:getLocalVar('damageTaken') == 0 and
        mob:getHPP() < 100
    then
        battlefield:setLocalVar('prisheReact', 1)
        mob:setLocalVar('damageTaken', 1)
    end

    -- Reset animation after lance wears off
    if
        mob:getAnimationSub() == 3 and
        not mob:hasStatusEffect(xi.effect.TERROR)
    then
        mob:setAnimationSub(0)
        mob:stun(1500)
    end

    -- HP breakpoints: Force Chains use at every 10% HP
    -- Determine which Chains based on initiator race
    local nextBreakpoint = mob:getLocalVar('nextBreakpoint')
    if mob:getHPP() < nextBreakpoint then
        local initRace = battlefield:getLocalVar('initRace')
        mob:useMobAbility(raceToChains[initRace].skill)

        mob:setLocalVar('nextBreakpoint', nextBreakpoint - 10)
    end
end

entity.onSpellPrecast = function(mob, spell)
    if spell:getID() == xi.magic.spell.COMET then
        spell:setMPCost(1)
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    -- High chance to use Chains move
    -- Determine which Chains based on initiator race
    local initRace = battlefield:getLocalVar('initRace')
    if math.random(1, 100) <= 50 then
        return raceToChains[initRace].skill
    end

    local tpList =
    {
        xi.mobSkill.MALEVOLENT_BLESSING_1,
        xi.mobSkill.PESTILENT_PENANCE_1,
        xi.mobSkill.EMPTY_SALVATION_1,
        xi.mobSkill.INFERNAL_DELIVERANCE_1,
    }

    -- Otherwise choose from TP moves
    return tpList[math.random(#tpList)]
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local battlefield = mob:getBattlefield()
    if not battlefield then
        return
    end

    -- Send appropriate message when using Chains move
    local skillID = skill:getID()
    local initRace = battlefield:getLocalVar('initRace')
    if
        skillID == raceToChains[initRace].skill and
        mob:getTarget() == target -- Prevents multiple messages due to AOE
    then
        mob:messageText(mob, raceToChains[initRace].message)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local battlefield = mob:getBattlefield()
        if not battlefield then
            return
        end

        battlefield:setLocalVar('phase', 1)
    end
end

return entity
