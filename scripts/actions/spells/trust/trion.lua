-----------------------------------
-- Trust: Trion
-- Royal Bash is stronger than a normal Shield Bash.
-- Royal Saviour is a secondary, stronger version of Sentinel. Trion alternates between this and the normal version of Sentinel.
-- Trion tries to interrupt TP-abilities with Royal Bash.
-- Uses TP randomly and does not try to skillchain.
-- With his two defensive TP moves, he's not likely to interrupt skillchains much.
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
        [xi.magic.spell.CURILLA] = xi.trust.messageOffset.TEAMWORK_1,
        [xi.magic.spell.RAHAL] = xi.trust.messageOffset.TEAMWORK_2,
        [xi.magic.spell.HALVER] = xi.trust.messageOffset.TEAMWORK_3,
    })

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
    mob:addMod(xi.mod.FASTCAST, 30)
    mob:addMod(xi.mod.ENMITY, 15)
    mob:addMod(xi.mod.DMG, -500) -- Damage Taken -5%
    mob:addMod(xi.mod.HPP, 10)
    mob:addMod(xi.mod.MPP, 10)

    if lvl >= 5 then
        mob:addGambit(ai.t.SELF, { ai.c.ALWAYS, 0 }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.PROVOKE })
    end

    if lvl >= 15 then
        mob:addGambit(ai.t.TARGET, { ai.l.OR(
            { ai.c.CASTING_MA, 0 },
            { ai.c.READYING_JA, 0 },
            { ai.c.READYING_MS, 0 },
            { ai.c.READYING_WS, 0 }) }, { ai.r.MS, ai.s.SPECIFIC, xi.mobSkill.ROYAL_BASH_TRUST }, 60)
    end

    if lvl >= 30 then
        mob:addGambit(ai.t.SELF, { ai.c.NOT_STATUS, xi.effect.SENTINEL }, { ai.r.JA, ai.s.SPECIFIC, xi.ja.SENTINEL })
    end

    mob:addGambit(ai.t.TARGET, { ai.c.NOT_STATUS, xi.effect.FLASH }, { ai.r.MA, ai.s.SPECIFIC, xi.magic.spell.FLASH      })
    mob:addGambit(ai.t.PARTY,  { ai.c.HPP_LT,     75              }, { ai.r.MA, ai.s.HIGHEST,  xi.magic.spellFamily.CURE })

    mob:setTrustTPSkillSettings(ai.tp.RANDOM, ai.s.RANDOM, 1500)

    mob:addListener('WEAPONSKILL_USE', 'TRION_WEAPONSKILL_USE', function(mobArg, target, skill, tp, action, damage)
        if skill:getID() == xi.mobSkill.ROYAL_SAVIOR_TRUST then -- Royal Savior
            -- O great kings of the noble line of d'Oraguille, shield me from harm!
            xi.trust.message(mobArg, xi.trust.messageOffset.SPECIAL_MOVE_1)
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
