-----------------------------------
-- Trust: Monberaux
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return xi.trust.canCast(caster, spell)
end

spellObject.onSpellCast = function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end

spellObject.onMobSpawn = function(mob)
    -- TODO: Summon (1 dose of Final Elixir ready): I received a vial of a most valuable medicine. It should prove useful in times of emergency.
    -- TODO: Summon (2 doses of Final Elixir ready): I received two vials of a most valuable medicine. They should prove useful in times of emergency.
    -- TODO: Find right animation for Mix: Insomniant.
    -- TODO: Add PLD/RUN traits like Resist Sleep and Tenacity.
    -- TODO: Add Vaccine skill (removes plague)
    -- TODO: Add Gold Needle skill (remove petrify)
    -- TODO: Add Holy Water skill (removes curse, zombie, and doom)
    -- TODO: Add Cover ability with proper conditions (stand behind Monberaux when you have top enmity)
    -- TODO: Add mechanic for turning status removal skills into AoE -- https://www.bg-wiki.com/ffxi/BGWiki:Trusts#Monberaux
    xi.trust.message(mob, xi.trust.messageOffset.SPAWN)

    local healingMoveCooldown = 3 -- Retail values from BGWiki

    -- Tends to be particular about which potions to use. Seems to favor healing for just the
    -- right amount of HP instead of defaulting to the highest-rank potion.
    mob:addMod(xi.mod.MPP, -90)
    mob:addSimpleGambit(ai.t.CASTER, ai.c.MPP_LT, 25, ai.r.MS, ai.s.SPECIFIC, 4254, healingMoveCooldown) -- Mix: Dry Ether Concoction
    mob:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 90, ai.r.MS, ai.s.SPECIFIC, 4236, healingMoveCooldown) -- Max Potion (500 HP)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.HPP_LT, 75, ai.r.MS, ai.s.SPECIFIC, 4237, healingMoveCooldown) -- Mix: Max Potion (700 HP)
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, xi.effect.POISON, ai.r.MS, ai.s.SPECIFIC, 4238, healingMoveCooldown) -- Mix: Antidote
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, xi.effect.SILENCE, ai.r.MS, ai.s.SPECIFIC, 4241, healingMoveCooldown) -- Echo Drops
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS, xi.effect.PARALYSIS, ai.r.MS, ai.s.SPECIFIC, 4247, healingMoveCooldown) -- Mix: Para-B-Gone
    mob:addSimpleGambit(ai.t.PARTY, ai.c.STATUS_FLAG, xi.effectFlag.ERASABLE, ai.r.MS, ai.s.SPECIFIC, 4245, healingMoveCooldown) -- Mix: Panacea-1
    mob:addSimpleGambit(ai.t.PARTY, ai.c.NOT_STATUS, xi.effect.REGEN, ai.r.MS, ai.s.SPECIFIC, 4257, healingMoveCooldown) -- Mix: Life Water
    mob:addSimpleGambit(ai.t.PARTY, ai.c.NOT_STATUS, xi.effect.STR_BOOST, ai.r.MS, ai.s.SPECIFIC, 4261, healingMoveCooldown) -- Mix: Samson's Strength
    mob:addSimpleGambit(ai.t.PARTY, ai.c.NOT_STATUS, xi.effect.MAGIC_DEF_BOOST, ai.r.MS, ai.s.SPECIFIC, 4259, healingMoveCooldown) -- Mix: Dragon Shield
    mob:addSimpleGambit(ai.t.PARTY, ai.c.NOT_STATUS, xi.effect.MAGIC_ATK_BOOST, ai.r.MS, ai.s.SPECIFIC, 4258, healingMoveCooldown) -- Mix: Elemental Power
    mob:addSimpleGambit(ai.t.PARTY, ai.c.NOT_STATUS, xi.effect.PROTECT, ai.r.MS, ai.s.SPECIFIC, 4255, healingMoveCooldown) -- Mix: Guard Drink
    -- mob:addSimpleGambit(ai.t.PARTY, ai.c.NOT_STATUS, xi.effect.NEGATE_SLEEP, ai.r.MS, ai.s.SPECIFIC, 4256, healingMoveCooldown) -- Insomniant. Disabled because animation when used is completely wrong.
    mob:addSimpleGambit(ai.t.TARGET, ai.c.HP_MISSING, 99, ai.r.MS, ai.s.SPECIFIC, 4260, healingMoveCooldown) -- Dark Potion (666 Dark Damage)

    mob:setAutoAttackEnabled(false)

    -- No TP for Monberaux
    mob:addListener('COMBAT_TICK', 'MONBERAUX_CTICK', function(mobArg)
        mobArg:setTP(0)
    end)

    -- This listener is needed for Monberaux to display the correct skill name in the combat log.
    mob:addListener('WEAPONSKILL_USE', 'MONBERAUX_WS', function(mobArg, targetArg, skillid, spentTP, action)
        action:setCategory(xi.action.MOBABILITY_FINISH)
    end)

    mob:setMobMod(xi.mobMod.TRUST_DISTANCE, xi.trust.movementType.NO_MOVE)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
