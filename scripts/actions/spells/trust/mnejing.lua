-----------------------------------
-- Trust: Mnejing
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

    mob:setMobMod(xi.mobMod.CAN_SHIELD_BLOCK, 1)
    mob:setMobMod(xi.mobMod.CAN_PARRY, 3)

    mob:setMod(xi.mod.SHIELD_MASTERY_TP, 40)
    mob:setMod(xi.mod.SHIELDBLOCKRATE, 45)
    mob:addMod(xi.mod.ENMITY, 15)
    mob:addMod(xi.mod.DMG, -375) -- Passive -37.5% Damage Taken Reduction.
    mob:addMod(xi.mod.HPP, 20)

    local lastSynergyBonus = 0

    mob:addListener('COMBAT_TICK', 'MNEJING_CTICK', function(mobArg)
        local targetBonus = 0
        local party = mobArg:getMaster():getPartyWithTrusts()

        for _, member in pairs(party) do
            if member:getObjType() == xi.objType.TRUST then
                if member:getTrustID() == xi.magic.spell.NASHMEIRA then
                    targetBonus = 10
                end
            end
        end

        if targetBonus ~= lastSynergyBonus then
            mobArg:delMod(xi.mod.DEF, lastSynergyBonus)
            mobArg:delMod(xi.mod.ENMITY, lastSynergyBonus)
            mobArg:addMod(xi.mod.DEF, targetBonus)
            mobArg:addMod(xi.mod.ENMITY, targetBonus)

            lastSynergyBonus = targetBonus
        end
    end)

    mob:addGambit(ai.t.TARGET, { ai.c.ALWAYS,      0                        }, { ai.r.MS, ai.s.SPECIFIC, xi.mobSkill.PROVOKE_AUTOMATON     }, 30)
    mob:addGambit(ai.t.TARGET, { ai.c.NOT_STATUS,  xi.effect.FLASH          }, { ai.r.MS, ai.s.SPECIFIC, xi.mobSkill.FLASHBULB_AUTOMATON   }, 45)
    mob:addGambit(ai.t.TARGET, { ai.c.READYING_MS, 0                        }, { ai.r.MS, ai.s.SPECIFIC, xi.mobSkill.SHIELD_BASH_AUTOMATON }, 30)
    mob:addGambit(ai.t.TARGET, { ai.c.READYING_WS, 0                        }, { ai.r.MS, ai.s.SPECIFIC, xi.mobSkill.SHIELD_BASH_AUTOMATON }, 30)
    mob:addGambit(ai.t.TARGET, { ai.c.STATUS_FLAG, xi.effectFlag.DISPELABLE }, { ai.r.MS, ai.s.SPECIFIC, xi.mobSkill.DISRUPTOR_AUTOMATON   }, 15)

    mob:setTrustTPSkillSettings(ai.tp.CLOSER_UNTIL_TP, ai.s.RANDOM, 1500)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
