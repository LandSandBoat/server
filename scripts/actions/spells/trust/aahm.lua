-----------------------------------
-- Trust: AAHM
-- Possesses HP+20%
-- Possesses an Utsusemi +1 trait which grants AA HM an extra shadow.
-- If there is a Tank in the party, behaves as a damage dealer: Uses Innin, Berserk.
-- If there are no other tanks in the party, behaves as a tank: Uses Yonin, Warcry.
-- Uses Provoke in both situations in order to be sub tank.
-- Casts debuffs when does not have hate.
-- Uses weapon skills at 1000 TP and does not try to skillchain.
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
    xi.trust.message(mob, xi.trust.messageOffset.SPAWN)

    mob:addMobMod(xi.mobMod.CAN_PARRY, 3)

    mob:addMod(xi.mod.UTSUSEMI_BONUS, 1)
    mob:addMod(xi.mod.FASTCAST, 30)
    mob:addMod(xi.mod.ENMITY, 15)
    mob:addMod(xi.mod.DUAL_WIELD, 10)
    mob:addMod(xi.mod.DMG, -500) -- Damage Taken -5%
    mob:addMod(xi.mod.HPP, 20)

    local lvl = mob:getMainLvl()
    local lastSynergyBonus = 0

    -- Dynamic modifier that checks party member list on tick to apply
    mob:addListener('COMBAT_TICK', 'AAHM_CTICK', function(mobArg)
        local synergyMembers =
        {
            xi.magic.spell.AAEV,
            xi.magic.spell.AAMR,
            xi.magic.spell.AATT,
            xi.magic.spell.AAGK
        }

        local synergyCount = 0
        local party = mobArg:getMaster():getPartyWithTrusts()

        for _, member in pairs(party) do
            if member:getObjType() == xi.objType.TRUST then
                local trustId = member:getTrustID()
                for _, sId in ipairs(synergyMembers) do
                    if trustId == sId then
                        synergyCount = synergyCount + 1
                        break
                    end
                end
            end
        end

        -- Determine what the bonus should be
        local targetBonus = (synergyCount == #synergyMembers) and 50 or 0
        -- Only update if the state has changed
        if targetBonus ~= lastSynergyBonus then
            -- Subtract exactly what we added last time
            mobArg:delMod(xi.mod.MEVA, lastSynergyBonus)
            -- Add the new bonus
            mobArg:addMod(xi.mod.MEVA, targetBonus)
            -- Update lastSynergyBonus
            lastSynergyBonus = targetBonus
        end
    end)

    if lvl >= 10 then
        mob:addGambit(ai.t.TARGET, { ai.c.ALWAYS, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.PROVOKE })
    end

    if lvl >= 30 then
        mob:addGambit(ai.t.SELF, { { ai.c.NOT_PT_HAS_TANK, 0 }, { ai.c.NOT_STATUS, xi.effect.BERSERK } }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.BERSERK })
    end

    if lvl >= 40 then
        mob:addGambit(ai.t.SELF, { { ai.c.NOT_PT_HAS_TANK, 0 }, { ai.c.NOT_STATUS, xi.effect.INNIN } }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.INNIN })
        mob:addGambit(ai.t.SELF, { { ai.c.PT_HAS_TANK,     0 }, { ai.c.NOT_STATUS, xi.effect.YONIN } }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.YONIN })
    end

    if lvl >= 70 then
        mob:addGambit(ai.t.SELF, { { ai.c.PT_HAS_TANK, 0 }, { ai.c.NOT_STATUS, xi.effect.WARCRY } }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.WARCRY })
    end

    mob:addGambit(ai.t.SELF,    { ai.c.NOT_STATUS,         xi.effect.MIGAWARI   }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.MIGAWARI_ICHI  })
    mob:addGambit(ai.t.SELF,    { ai.c.NOT_STATUS,         xi.effect.COPY_IMAGE }, { ai.r.MA, ai.s.HIGHEST,  xi.magic.spellFamily.UTSUSEMI })
    mob:addGambit(ai.t.TARGET,  { ai.c.NOT_HAS_TOP_ENMITY, 0                    }, { ai.r.MA, ai.s.HIGHEST,  xi.magic.spellFamily.HOJO     }, 30)
    mob:addGambit(ai.t.TARGET,  { ai.c.NOT_HAS_TOP_ENMITY, 0                    }, { ai.r.MA, ai.s.HIGHEST,  xi.magic.spellFamily.KURAYAMI }, 30)

    mob:setTrustTPSkillSettings(ai.tp.ASAP, ai.s.RANDOM)

    mob:addListener('WEAPONSKILL_USE', 'AAHM_WEAPONSKILL_USE', function(mobArg, target, skill, tp, action)
        if skill:getID() == xi.mobSkill.CROSS_REAVER_3 then
            xi.trust.message(mobArg, xi.trust.messageOffset.SPECIAL_MOVE_1) -- Apathy strikes!
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
