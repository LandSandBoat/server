-----------------------------------
-- Trust: Valaineral
-----------------------------------
---@type TSpellTrust
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spellObject.onSpellCast = function(caster, target, spell)
    -- Records of Eminence: Alter Ego: Valaineral
    if caster:getEminenceProgress(933) then
        xi.roe.onRecordTrigger(caster, 933)
    end

    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.SPAWN)

    mob:setMobMod(xi.mobMod.CAN_SHIELD_BLOCK, 1)
    mob:setMobMod(xi.mobMod.CAN_PARRY, 3)

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
    mob:setMod(xi.mod.SHIELDBLOCKRATE, 35)
    mob:addMod(xi.mod.SPELLINTERRUPT, 30)
    mob:addMod(xi.mod.CURE_POTENCY, 50)
    mob:addMod(xi.mod.FASTCAST, 30)
    mob:addMod(xi.mod.REFRESH, 2)
    mob:addMod(xi.mod.ENMITY, 25)
    mob:addMod(xi.mod.DMG, -800) -- Damage Taken -8%
    mob:addMod(xi.mod.HPP, 10)
    mob:addMod(xi.mod.MPP, 20)

    if lvl >= 1 then
        mob:addGambit(ai.t.TARGET, { ai.c.VAL_URIEL_CHECK, 0 }, { ai.r.MS, ai.s.SPECIFIC, xi.mobSkill.URIEL_BLADE_1 })
    end

    if lvl >= 5 then
        mob:addGambit(ai.t.SELF, { ai.c.ALWAYS, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.PROVOKE })
    end

    if lvl >= 30 then
        mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.SENTINEL }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.SENTINEL })
    end

    if lvl >= 50 then
        mob:addGambit(ai.t.SELF, { { ai.c.MPP_LT,         50             }, { ai.c.TP_GTE,     1000               } }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.CHIVALRY })
        mob:addGambit(ai.t.SELF, { { ai.c.JA_ON_COOLDOWN, xi.ja.SENTINEL }, { ai.c.NOT_STATUS, xi.effect.SENTINEL } }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.DEFENDER })
    end

    if lvl >= 62 then
        mob:addGambit(ai.t.TARGET, { ai.c.STATUS, xi.effect.MANAFONT    }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.RAMPART })
        mob:addGambit(ai.t.TARGET, { ai.c.STATUS, xi.effect.CHAINSPELL  }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.RAMPART })
        mob:addGambit(ai.t.TARGET, { ai.c.STATUS, xi.effect.ASTRAL_FLOW }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.RAMPART })
    end

    if lvl >= 70 then
        mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.MAJESTY }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.MAJESTY })
    end

    if lvl >= 75 then
        mob:addGambit(ai.t.TARGET, { ai.c.CASTING_DEBUFF, 0               }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.FEALTY        })
        mob:addGambit(ai.t.TARGET, { ai.c.NOT_STATUS,     xi.effect.FLASH }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.DIVINE_EMBLEM })
    end

    mob:addGambit(ai.t.SELF,   { ai.c.NOT_STATUS, xi.effect.PROTECT  }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.PROTECT })
    mob:addGambit(ai.t.TARGET, { ai.c.NOT_STATUS, xi.effect.FLASH    }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.FLASH        })
    mob:addGambit(ai.t.SELF,   { ai.c.NOT_STATUS, xi.effect.REPRISAL }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.REPRISAL     })
    mob:addGambit(ai.t.PARTY,  { ai.c.HPP_LT,     50                 }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE    })
    mob:addGambit(ai.t.SELF,   { ai.c.HPP_LT,     70                 }, { ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.CURE    })
    mob:addGambit(ai.t.SELF,   { ai.c.NOT_STATUS, xi.effect.ENLIGHT  }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.ENLIGHT      })
    mob:addGambit(ai.t.SELF,   { ai.c.NOT_STATUS, xi.effect.PHALANX  }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.PHALANX      })
    mob:addGambit(ai.t.PARTY,  { ai.c.STATUS,     xi.effect.SLEEP_I  }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.CURE         })

    mob:setTrustTPSkillSettings(ai.tp.OPENER, ai.s.RANDOM, 2000)

    mob:addListener('WEAPONSKILL_USE', 'VALAINERAL_WEAPONSKILL_USE', function(mobArg, target, skill, tp, action, damage)
        if skill:getID() == xi.mobSkill.URIEL_BLADE_1 then -- Uriel Blade
            -- Let the Blade of the Conqueror once again bring glory to the Kingdom!
            if math.random(1, 100) <= 33 then
                if target:getID() == skill:getPrimaryTargetID() then
                    xi.trust.message(mobArg, xi.trust.messageOffset.SPECIAL_MOVE_1)
                end
            end

            mobArg:setLocalVar('[Gambit]LastUrielTime', GetSystemTime())
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
