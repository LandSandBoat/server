-----------------------------------
-- Trust: Kuyin Hathdenna
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
    local master = mob:getMaster()
    local hasTitle = false
    local titleBonus = 0

    if master then
        hasTitle = master:hasTitle(xi.title.KIT_EMPATHIZER)
    end

    if hasTitle then
        -- Kyuin only says this line when the master has the title "Kit Empathizer" from the mog garden quest to enable her employment.
        xi.trust.message(mob, xi.trust.messageOffset.SPAWN)
        titleBonus = 1
    else
        -- No title: I'd like you to gimme a job.
        xi.trust.message(mob, xi.trust.messageOffset.TEAMWORK_1)
    end

    mob:setMobMod(xi.mobMod.TRUST_DISTANCE, xi.trust.movementType.NON_COMBAT)

    mob:addMod(xi.mod.AURA_SIZE, 600) -- Trust have a 12 yalm aura 6 base + 6 from mod

    local employmentBonus = 0 -- TODO: Add dex boost from mog garden employment (not implimented yet).
    -- +1 Bonus when Kuyin is employed in your Mog Garden.
    -- +1 Bonus when the player has the title "Kit Empathizer".

    local effectParams =
    {
        power = 6,
        origin = mob,
        tick = 3,
        subType = xi.effect.TRUST_AURA_ACC,
        subPower = mob:getMainLvl() + employmentBonus + titleBonus, -- the effect script will adjust the power using xi.trust.trustAuraValue in trust.lua
        subIcon = xi.effect.GEO_ACCURACY_BOOST,
        tier = xi.auraTarget.ALLIES,
        flag = xi.effectFlag.AURA
    }

    mob:addStatusEffect(xi.effect.COLURE_ACTIVE, effectParams)

    mob:addGambit(ai.t.SELF, { { ai.c.TIMER, 5 }, { ai.c.RANDOM, 45 } }, { ai.r.ANIM_STRING, ai.s.RANDOM_ANIMATION, 3 })

    mob:setAutoAttackEnabled(false)
end

spellObject.onMobDespawn = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DESPAWN)
end

spellObject.onMobDeath = function(mob)
    xi.trust.message(mob, xi.trust.messageOffset.DEATH)
end

return spellObject
