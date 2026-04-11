-----------------------------------
-- Trust: August
-----------------------------------
---@type TSpellTrust
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.ARCIELA]   = xi.trust.messageOffset.TEAMWORK_1,
        [xi.magic.spell.TEODOR]    = xi.trust.messageOffset.TEAMWORK_2,
        [xi.magic.spell.ROSULATIA] = xi.trust.messageOffset.TEAMWORK_3,
        [xi.magic.spell.MORIMAR]   = xi.trust.messageOffset.TEAMWORK_4,
    })

    local killerEffects =
    {
        xi.mod.VERMIN_KILLER,
        xi.mod.BIRD_KILLER,
        xi.mod.AMORPH_KILLER,
        xi.mod.LIZARD_KILLER,
        xi.mod.AQUAN_KILLER,
        xi.mod.PLANTOID_KILLER,
        xi.mod.BEAST_KILLER,
        xi.mod.UNDEAD_KILLER,
        xi.mod.ARCANA_KILLER,
        xi.mod.DRAGON_KILLER,
        xi.mod.DEMON_KILLER,
        xi.mod.EMPTY_KILLER,
        -- xi.mod.HUMANOID_KILLER, -- This can be uncommented once https://github.com/LandSandBoat/server/issues/7610 has been fixed
        xi.mod.LUMINIAN_KILLER,
        xi.mod.LUMINION_KILLER,
    }

    for i = 1, #killerEffects do
        mob:addMod(killerEffects[i], 8) -- this is what you would get using all the Founders Gear set
    end

    local lvl = mob:getMainLvl()
    local shieldMasteryPower = 0

    if lvl >= 96 then
        shieldMasteryPower = 40
    elseif lvl >= 75 then
        shieldMasteryPower = 30
    elseif lvl >= 50 then
        shieldMasteryPower = 20
    elseif lvl >= 25 then
        shieldMasteryPower = 10
    end

    mob:setMod(xi.mod.SHIELD_MASTERY_TP, shieldMasteryPower)
    mob:addMod(xi.mod.DMG, -10)
    mob:addMod(xi.mod.UFASTCAST, 50) -- August casts stupid fast
    mob:setMod(xi.mod.SHIELDBLOCKRATE, xi.trust.modGrowthValMax(mob, 35)) -- around 35% max block rate at 99 from testing
    mob:addMod(xi.mod.HPP, 10)
    mob:addMod(xi.mod.ENMITY, 25)

    -- Founders gear mods: August gets all effects from founders gear
    -- see xi.trust.modGrowthVal in trust.lua for current curve value
    mob:addMod(xi.mod.MDEF, xi.trust.modGrowthValMax(mob, 12))            -- Founders gear: MDEF + 12
    mob:addMod(xi.mod.SPELLINTERRUPT, xi.trust.modGrowthValMax(mob, 30))  -- Founders gear: SIRD +30
    mob:addMod(xi.mod.HASTE_GEAR, xi.trust.modGrowthValMax(mob, 22))      -- Founders gear: Gear Haste +22
    mob:addMod(xi.mod.ACC, xi.trust.modGrowthValMax(mob, 60))             -- Founders gear: ACC + 60
    mob:addMod(xi.mod.ATT, xi.trust.modGrowthValMax(mob, 60))             -- Founders gear: ATT +60
    mob:addMod(xi.mod.MACC, xi.trust.modGrowthValMax(mob, 60))            -- Founders gear: MACC + 60
    mob:addMod(xi.mod.EVA, xi.trust.modGrowthValMax(mob, 183))            -- Founders gear: EVA + 183
    mob:addMod(xi.mod.MEVA, xi.trust.modGrowthValMax(mob, 299))           -- Founders gear: MEVA + 299
    mob:addMod(xi.mod.MATT, xi.trust.modGrowthValMax(mob, 60))            -- Founders gear: MATT + 60
    -- there is a few more, but these make the most sense for now.

    mob:setMobMod(xi.mobMod.CAN_SHIELD_BLOCK, 1)
    mob:setMobMod(xi.mobMod.CAN_PARRY, 3)

    mob:setAnimationSub(0) -- this is probably not needed but its here because August's daybreak status is tested against it.

    -- mob:addImmunity(xi.immunity.TERROR) -- this is wrong but we currently have no TERRORRES mod and no way to use one

    mob:addListener('COMBAT_TICK', 'AUGUST_CTICK', function(mobArg)
        local daybreakRecast  = 180 -- 3 minutes
        local daybreakEndTime = mobArg:getLocalVar('DaybreakEndTime')
        local daybreakUsed    = mobArg:getLocalVar('DaybreakUsed')
        local hppLow          = mobArg:getHPP() <= 66
        local now             = GetSystemTime()
        if
            mobArg:getMainLvl() >= 51 and
            mobArg:getAnimationSub() == 0 and
            (daybreakEndTime == 0 or now >= daybreakEndTime + daybreakRecast) and
            hppLow and
            daybreakUsed ~= 1
        then
            mobArg:useMobAbility(xi.mobSkill.DAYBREAK_TRUST)
            daybreakUsed = 1
        end
    end)

    -----------------------------------
    -- Gambits
    -----------------------------------

    mob:addGambit(ai.t.TARGET,                     { ai.c.NOT_STATUS,         xi.effect.FLASH         }, { ai.r.MA, ai.s.SPECIFIC,    xi.magic.spell.FLASH      })
    mob:addGambit(ai.t.SELF,                       { ai.c.NOT_HAS_TOP_ENMITY, 0                       }, { ai.r.JA, ai.s.SPECIFIC,    xi.ja.PROVOKE             })
    mob:addGambit(ai.t.SELF,                       { ai.c.HPP_LT,             75                      }, { ai.r.MA, ai.s.HIGHEST,     xi.magic.spellFamily.CURE })
    mob:addGambit(ai.t.SELF,                       { ai.c.NOT_STATUS,         xi.effect.SENTINEL      }, { ai.r.JA, ai.s.SPECIFIC,    xi.ja.SENTINEL            })
    mob:addGambit(ai.t.SELF,                       { ai.c.NOT_STATUS,         xi.effect.REPRISAL      }, { ai.r.MA, ai.s.SPECIFIC,    xi.magic.spell.REPRISAL   })
    mob:addGambit(ai.t.PARTY,                      { ai.c.HPP_LT,             50                      }, { ai.r.MA, ai.s.HIGHEST,     xi.magic.spellFamily.CURE })
    mob:addGambit(ai.t.SELF,                       { ai.c.NOT_STATUS,         xi.effect.PALISADE      }, { ai.r.JA, ai.s.SPECIFIC,    xi.ja.PALISADE            })

    -- Only uses Divine Emblen and Holy when daybreak active (subAnimation 5)
    mob:addGambit(ai.t.SELF, {
        { ai.c.SUB_ANIMATION,      5                       },
        { ai.c.NOT_STATUS,         xi.effect.DIVINE_EMBLEM },                                         }, { ai.r.JA, ai.s.SPECIFIC,    xi.ja.DIVINE_EMBLEM       })
    mob:addGambit(ai.t.TRIGGER_SELF_ACTION_TARGET, {
        { ai.c.SUB_ANIMATION,      5                       },
        { ai.c.STATUS,             xi.effect.DIVINE_EMBLEM },                                         }, { ai.r.MA, ai.s.HIGHEST,     xi.magic.spellFamily.HOLY })

    mob:setMobSkillAttack(1197)

    mob:setTrustTPSkillSettings(ai.tp.OPENER, ai.s.SPECIAL_AUGUST)

    mob:addListener('WEAPONSKILL_USE', 'AUGUST_WEAPONSKILL_USE', function(mobArg, target, skill, tp, action)
        if skill:getID() == xi.mobSkill.DAYBREAK_TRUST then -- Daybreak
            mob:timer(2000, function()
                mob:entityAnimationPacket('ids1') -- Wings on
            end)
        elseif skill:getID() == xi.mobSkill.NO_QUARTER_TRUST then -- No Quarter
            -- Come! Show me your finest form!
            xi.trust.message(mobArg, xi.trust.messageOffset.SPECIAL_MOVE_1)
            mobArg:setLocalVar('DaybreakUsed', 0)
            mob:timer(1000, function()
                mob:entityAnimationPacket('ids2') -- Wings off
            end)
        end
    end)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
