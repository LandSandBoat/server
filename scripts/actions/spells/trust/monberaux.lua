-----------------------------------
-- Trust: Monberaux
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
    -- TODO: Find right animation for Mix: Insomniant.
    -- TODO: Add PLD/RUN traits like Resist Sleep and Tenacity.
    -- TODO: Add Cover ability with proper conditions (stand behind Monberaux when you have top enmity)
    local finalElixir = mob:getMaster():getCharVar('finalElixir') -- CVar used to store Elixir donation info.
    local potAoe = mob:getMaster():getCharVar('monbAoe') -- CVar used to store gil donation info.

    if potAoe == 0 and finalElixir == 0 then
        xi.trust.message(mob, xi.trust.messageOffset.SPAWN)
    elseif potAoe == 0 and finalElixir == 1 then
        xi.trust.message(mob, xi.trust.messageOffset.TEAMWORK_1) -- 1 Elixir
    elseif potAoe == 0 and finalElixir >= 2 then
        xi.trust.message(mob, xi.trust.messageOffset.TEAMWORK_2) -- 2 Elixir
    elseif potAoe == 1 and finalElixir < 1 then
        xi.trust.message(mob, xi.trust.messageOffset.TEAMWORK_3) -- Gil donation (AoE)
    elseif potAoe == 1 and finalElixir == 1 then
        xi.trust.message(mob, xi.trust.messageOffset.TEAMWORK_4) -- 1 Elixir and Gil
    elseif potAoe == 1 and finalElixir >= 2 then
        xi.trust.message(mob, xi.trust.messageOffset.TEAMWORK_5) -- ALL Donations
    end

    local healingMoveCooldown = math.random(3, 4) -- Mix I Retail values from BGWiki
    local buffMoveCooldown = 60 -- Mix II Retail values from BGWiki
    local mpMoveCooldown = 90 -- Mix III Retail values from BGWiki

    -- MobMods --
        mob:setMod(xi.mod.MPP, -90)
        mob:setMod(xi.mod.SLEEPRES, 100) -- Handle negate sleep
        mob:setMod(xi.mod.LULLABYRES, 100) -- Handle negate sleep
        mob:setMod(xi.mod.STATUSRES, 15)

    -- Guard Drink should always be the first spell he casts. --
        mob:addGambit(ai.t.PARTY, { ai.c.NOT_STATUS, xi.effect.PROTECT }, { ai.r.MS, ai.s.SPECIFIC, 4255 }, healingMoveCooldown) -- Mix: Guard Drink (Prot/Shell)
        mob:addGambit(ai.t.PARTY, { ai.c.NOT_STATUS, xi.effect.SHELL }, { ai.r.MS, ai.s.SPECIFIC, 4255 }, healingMoveCooldown) -- Mix: Guard Drink (Prot/Shell)
    -- Handle his Final Elixir (item donation) system, will use whenever a party memeber is asleep --
        if finalElixir ~= 0 then
            mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.SLEEP_I }, { ai.r.MS, ai.s.SPECIFIC, 4231 }, healingMoveCooldown)
        end

    -- Top Priority Heals --
        mob:addGambit(ai.t.PARTY, { ai.c.HPP_LT, 40 }, { ai.r.MS, ai.s.SPECIFIC, 4237 }, healingMoveCooldown) -- Mix: Max Potion (700 HP)
        mob:addGambit(ai.t.PARTY, { ai.c.HPP_LT, 55 }, { ai.r.MS, ai.s.SPECIFIC, 4236 }, healingMoveCooldown) -- Max Potion (500 HP)

    -- Mix I AoE --
        if potAoe == 1 then
            mob:addGambit(ai.t.PARTY, { ai.l.OR(
                                { ai.c.STATUS, xi.effect.CURSE_I },
                                { ai.c.STATUS, xi.effect.CURSE_II },
                                { ai.c.STATUS, xi.effect.BANE },
                                { ai.c.STATUS, xi.effect.DOOM })
                                    }, { ai.r.MS, ai.s.SPECIFIC, 4242 }, healingMoveCooldown)   -- AoE Holy Water
            mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.BLINDNESS }, { ai.r.MS, ai.s.SPECIFIC, 4240 }, healingMoveCooldown) -- AoE Mix: Eye Drops
            mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.POISON }, { ai.r.MS, ai.s.SPECIFIC, 4238 }, healingMoveCooldown) -- AoE Mix: Antidote
            mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.SILENCE }, { ai.r.MS, ai.s.SPECIFIC, 4241 }, healingMoveCooldown) -- AoE Echo Drops
            mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.PARALYSIS }, { ai.r.MS, ai.s.SPECIFIC, 4239 }, healingMoveCooldown) -- AoE Mix: Para-B-Gone
            mob:addGambit(ai.t.PARTY, { ai.c.STATUS_FLAG, xi.effectFlag.ERASABLE }, { ai.r.MS, ai.s.SPECIFIC, 4245 }, healingMoveCooldown) -- AoE Mix: Panacea-1
            mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.PLAGUE }, { ai.r.MS, ai.s.SPECIFIC, 4243 }, healingMoveCooldown) -- AoE Mix: Vaccine
            mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.PETRIFICATION }, { ai.r.MS, ai.s.SPECIFIC, 4244 }, healingMoveCooldown) -- AoE Mix: Gold Needle
    -- Mix I Single Target --
        elseif potAoe == 0 then
            mob:addGambit(ai.t.PARTY, { ai.l.OR(
                                { ai.c.STATUS, xi.effect.CURSE_I },
                                { ai.c.STATUS, xi.effect.CURSE_II },
                                { ai.c.STATUS, xi.effect.BANE },
                                { ai.c.STATUS, xi.effect.DOOM })
                                    }, { ai.r.MS, ai.s.SPECIFIC, 4242 }, healingMoveCooldown)   -- Holy Water
            mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.BLINDNESS }, { ai.r.MS, ai.s.SPECIFIC, 4248 }, healingMoveCooldown) -- Mix: Eye Drops
            mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.POISON }, { ai.r.MS, ai.s.SPECIFIC, 4246 }, healingMoveCooldown) -- Mix: Antidote
            mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.SILENCE }, { ai.r.MS, ai.s.SPECIFIC, 4249 }, healingMoveCooldown) -- Echo Drops
            mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.PARALYSIS }, { ai.r.MS, ai.s.SPECIFIC, 4247 }, healingMoveCooldown) -- Mix: Para-B-Gone
            mob:addGambit(ai.t.PARTY, { ai.c.STATUS_FLAG, xi.effectFlag.ERASABLE }, { ai.r.MS, ai.s.SPECIFIC, 4253 }, healingMoveCooldown) -- Mix: Panacea-1
            mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.PLAGUE, ai.r.MS }, { ai.s.SPECIFIC, 4251 }, healingMoveCooldown) -- Vaccine
            mob:addGambit(ai.t.PARTY, { ai.c.STATUS, xi.effect.PETRIFICATION }, { ai.r.MS, ai.s.SPECIFIC, 4252 }, healingMoveCooldown) -- Mix: Gold Needle
        end

        --mob:addGambit(ai.t.PARTY, {ai.c.NOT_STATUS, xi.effect.NEGATE_SLEEP}, {ai.r.MS, ai.s.SPECIFIC, 4256}, healingMoveCooldown) -- Insomniant. Disabled because animation when used is completely wrong.
    -- Mix II--
        mob:addGambit(ai.t.PARTY, { ai.c.NOT_STATUS, xi.effect.REGEN }, { ai.r.MS, ai.s.SPECIFIC, 4257 }, buffMoveCooldown) -- Mix: Life Water
        mob:addGambit(ai.t.PARTY, { ai.c.NOT_STATUS, xi.effect.STR_BOOST }, { ai.r.MS, ai.s.SPECIFIC, 4261 }, buffMoveCooldown) -- Mix: Samson's Strength
        mob:addGambit(ai.t.PARTY, { ai.c.NOT_STATUS, xi.effect.MAGIC_DEF_BOOST }, { ai.r.MS, ai.s.SPECIFIC, 4259 }, buffMoveCooldown) -- Mix: Dragon Shield
        mob:addGambit(ai.t.CASTER, { ai.c.NOT_STATUS, xi.effect.MAGIC_ATK_BOOST }, { ai.r.MS, ai.s.SPECIFIC, 4258 }, buffMoveCooldown) -- Mix: Elemental Power
        mob:addGambit(ai.t.TARGET, { ai.c.ALWAYS, 0 }, { ai.r.MS, ai.s.SPECIFIC, 4260 }, buffMoveCooldown) -- Dark Potion (666 Dark Damage)
    -- Mix III--
        mob:addGambit(ai.t.CASTER, { ai.c.MPP_LT, 50 }, { ai.r.MS, ai.s.SPECIFIC, 4254 }, mpMoveCooldown) -- Mix: Dry Ether Concoction
    -- Less Priority Heals --
        mob:addGambit(ai.t.PARTY, { ai.c.HPP_LT, 65 }, { ai.r.MS, ai.s.SPECIFIC, 4235 }, healingMoveCooldown) -- Hyper Potion (250 HP)
        --mob:addGambit(ai.t.PARTY, {ai.c.HPP_LT, 75}, {ai.r.MS, ai.s.SPECIFIC, 4234}, healingMoveCooldown) -- X-Potion (150 HP) -- Disabled to prevent super spam
        --mob:addGambit(ai.t.PARTY, {ai.c.HPP_LT, 85}, {ai.r.MS, ai.s.SPECIFIC, 4232}, healingMoveCooldown) -- Potion (50 HP) -- Disabled to prevent super spam

    -- Listener to handle removal of CharVar that handles elixir donation --
    mob:addListener('WEAPONSKILL_USE', 'MONBERAUX_WEAPONSKILL_USE', function(mobArg, targetArg, skillid, spentTP, action)
        local monbMast = mobArg:getMaster()
        local finalElixirL = monbMast:getCharVar('finalElixir')
        if skillid == 4231 then
            monbMast:setCharVar('finalElixir', finalElixirL - 1)
        end
    end)

    --Listener to SPECIAL_MOVE -- DISABLED needs correct coding for table
    --mob:addListener('WEAPONSKILL_BEFORE_USE', 'MONBERAUX_WEAPONSKILL_BEFORE_USE', function(mobArg, skillid)
    --local buffs = { 4234, 4239, 4240, 4241, 4242, 4243, 4244, 4245, 4246, 4247, 4248, 4248, 4249, 4250, 4251, 4252 } -- status condition removals only
    --if skillid == 4259 then
    --xi.trust.message(mob, xi.trust.messageOffset.SPECIAL_MOVE_1) -- Using Mix: Dragon Shield: Illness and unjury know no boundaries!
    --elseif skillid == buffs then
    --xi.trust.message(mob, xi.trust.messageOffset.SPECIAL_MOVE_2) -- Other: I shall administer a remedy immediately!
    --end
    --end)

    mob:setAutoAttackEnabled(false)

    -- No TP for Monberaux
    mob:addListener('COMBAT_TICK', 'MONBERAUX_CTICK', function(mobArg)
        mobArg:setTP(0)
    end)

    -- This listener is needed for Monberaux to display the correct skill name in the combat log.
    mob:addListener('WEAPONSKILL_USE', 'MONBERAUX_WS', function(mobArg, targetArg, skillid, spentTP, action)
        action:setCategory(xi.action.category.MOBABILITY_FINISH)
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
