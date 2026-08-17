-----------------------------------
-- Area: The Garden of Ru'Hmet
-- NM: Ix'aern DRK
-- !pos -240 5.00 440 35
-- !pos -280 5.00 240 35
-- !pos -560 5.00 239 35
-- !pos -600 5.00 440 35
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(IxAernDrkMob)
    IxAernDrkMob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    IxAernDrkMob:addImmunity(xi.immunity.BIND)
    IxAernDrkMob:addImmunity(xi.immunity.BLIND)
    IxAernDrkMob:addImmunity(xi.immunity.DARK_SLEEP)
    IxAernDrkMob:addImmunity(xi.immunity.ELEGY)
    IxAernDrkMob:addImmunity(xi.immunity.GRAVITY)
    IxAernDrkMob:addImmunity(xi.immunity.LIGHT_SLEEP)
    IxAernDrkMob:addImmunity(xi.immunity.PARALYZE)
    IxAernDrkMob:addImmunity(xi.immunity.SILENCE)
    IxAernDrkMob:addImmunity(xi.immunity.SLOW)
    IxAernDrkMob:addImmunity(xi.immunity.STUN)
    IxAernDrkMob:addImmunity(xi.immunity.TERROR)

    IxAernDrkMob:addListener('DEATH', 'AERN_DEATH', function(mob, killer)
        local timesReraised = mob:getLocalVar('AERN_RERAISES')
        if math.randomInt(1, 10) < 10 then
            -- reraise
            local target = mob:getTarget()
            if
                target:isPet() and
                not target:isAlive()
            then
                target = target:getMaster()
            end

            mob:setMobMod(xi.mobMod.NO_DROPS, 1)
            mob:timer(9000, function(mobArg)
                mobArg:setHP(mob:getMaxHP())
                mobArg:setMP(mob:getMaxMP())
                mobArg:setAnimationSub(3)
                mobArg:resetAI()
                mobArg:stun(3000)
                if
                    mobArg:checkDistance(target) < 25 and
                    target:isAlive()
                then
                    mobArg:updateClaim(target)
                    mobArg:updateEnmity(target)
                else
                    local partySize = killer:getPartySize() -- Check for other available valid aggro targets
                    local i = 1
                    if killer ~= nil then
                        for _, partyMember in pairs(killer:getAlliance()) do --TODO add enmity list check when binding avail
                            if partyMember:isAlive() and mobArg:checkDistance(partyMember) < 25 then
                                mobArg:updateClaim(partyMember)
                                mobArg:updateEnmity(partyMember)
                                break
                            elseif i == partySize then --if all checks fail just disengage
                                mobArg:disengage()
                            end

                            i = i + 1
                        end
                    else
                        mobArg:disengage()
                    end
                end

                mobArg:triggerListener('AERN_RERAISE', mobArg, timesReraised)
            end)
        else
            -- death
            mob:setMobMod(xi.mobMod.NO_DROPS, 0)
            -- DespawnMob(QnAernA)
            -- DespawnMob(QnAernB)
        end
    end)

    IxAernDrkMob:addListener('AERN_RERAISE', 'IX_DRK_RERAISE', function(mob, timesReraised)
        mob:setLocalVar('AERN_RERAISES', timesReraised + 1)
        mob:timer(5000, function(mobArg)
            mobArg:setAnimationSub(1)
        end)
    end)
end

entity.onMobSpawn = function(mob)
    mob:setAnimationSub(1)

    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            {
                id = xi.mobSkill.BLOOD_WEAPON_IXDRK,
                hpp = math.randomInt(90, 95),
                cooldown = 120,
                endCode = function(mobArg)
                    mobArg:setMagicCastingEnabled(false)
                    mobArg:timer(30000, function(mobTimerArg)
                        mobTimerArg:setMagicCastingEnabled(true)
                    end)
                end,
            }
        }
    })
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.FIRE_II,     target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 2] = { xi.magic.spell.BLIZZARD_II, target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 3] = { xi.magic.spell.AERO_II,     target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 4] = { xi.magic.spell.STONE_III,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 5] = { xi.magic.spell.THUNDER_II,  target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 6] = { xi.magic.spell.WATER_III,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
        [ 7] = { xi.magic.spell.POISON,      target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.POISON,   0, 100 },
        [ 8] = { xi.magic.spell.BIO_II,      target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIO,      4, 100 },
        [ 9] = { xi.magic.spell.STUN,        target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.STUN,     0, 100 },
        [10] = { xi.magic.spell.ABSORB_STR,  target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.STR_DOWN, 0, 100 },
        [11] = { xi.magic.spell.ABSORB_DEX,  target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.DEX_DOWN, 0, 100 },
        [12] = { xi.magic.spell.ABSORB_VIT,  target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.VIT_DOWN, 0, 100 },
        [13] = { xi.magic.spell.ABSORB_AGI,  target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.AGI_DOWN, 0, 100 },
        [14] = { xi.magic.spell.ABSORB_INT,  target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.INT_DOWN, 0, 100 },
        [15] = { xi.magic.spell.ABSORB_MND,  target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.MND_DOWN, 0, 100 },
        [16] = { xi.magic.spell.ABSORB_CHR,  target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.CHR_DOWN, 0, 100 },
        [17] = { xi.magic.spell.ABSORB_TP,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onMobDespawn = function(mob)
    mob:setLocalVar('AERN_RERAISES', 0)
end

return entity
