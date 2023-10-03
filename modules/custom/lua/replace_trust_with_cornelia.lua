-----------------------------------
-- Replace Trust with Trust: Cornelia (configurable)
--
-- The name of the spell itself can't be changed (would require client changes),
-- but everything else can be changed!
-----------------------------------
require('modules/module_utils')
require('scripts/globals/trust')
-----------------------------------
local m = Module:new('replace_trust_with_cornelia')

-- This is the filename of the trust you're trying to replace, without the '.lua' extension
local trustToReplaceName = 'kuyin_hathdenna'

m:addOverride(string.format('xi.actions.spells.trust.%s.onSpellCast', trustToReplaceName), function(caster, target, spell)
    -----------------------------------
    -- NOTE: This is the logic from xi.trust.spawn()
    -----------------------------------
    local trust = caster:spawnTrust(spell:getID())

    -- Records of Eminence: Call Forth an Alter Ego
    if caster:getEminenceProgress(932) then
        xi.roe.onRecordTrigger(caster, 932)
    end

    -----------------------------------
    -- New logic below
    -----------------------------------
    trust:setModelId(3119) -- Trust: Cornelia
    trust:renameEntity('Cornelia')

    local boostAmount = math.ceil((30 / 99) * caster:getMainLvl())
    trust:addStatusEffectEx(xi.effect.GEO_HASTE, xi.effect.GEO_HASTE, 6, 3, 0, xi.effect.GEO_HASTE, boostAmount, xi.auraTarget.ALLIES, xi.effectFlag.AURA)
    trust:addStatusEffectEx(xi.effect.GEO_ACCURACY_BOOST, xi.effect.GEO_ACCURACY_BOOST, 6, 3, 0, xi.effect.GEO_ACCURACY_BOOST, boostAmount, xi.auraTarget.ALLIES, xi.effectFlag.AURA)
    trust:addStatusEffectEx(xi.effect.GEO_MAGIC_ACC_BOOST, xi.effect.GEO_MAGIC_ACC_BOOST, 6, 3, 0, xi.effect.GEO_MAGIC_ACC_BOOST, boostAmount, xi.auraTarget.ALLIES, xi.effectFlag.AURA)
    -- TODO: Ranged accuracy boost

    trust:setAutoAttackEnabled(false)
    trust:setUnkillable(true)

    -- Cache this for later
    trust:setLocalVar('MASTER_ID', trust:getMaster():getID())
end)

m:addOverride(string.format('xi.actions.spells.trust.%s.onMobSpawn', trustToReplaceName), function(mob)
    for _, member in ipairs(mob:getMaster():getParty()) do
        if member:isPC() then
            member:PrintToPlayer('Cornelia, at your service.', 4, 'Cornelia') -- 4: MESSAGE_PARTY
        end
    end
end)

m:addOverride(string.format('xi.actions.spells.trust.%s.onMobDespawn', trustToReplaceName), function(mob)
    -- NOTE: Apparently getMaster() returns nil by now, so we're going to get the master's ID that
    --     : we cached earlier
    local masterId = mob:getLocalVar('MASTER_ID')
    local master = GetPlayerByID(masterId)
    for _, member in ipairs(master:getParty()) do
        if member:isPC() then
            member:PrintToPlayer('Remember: never give up!', 4, 'Cornelia') -- 4: MESSAGE_PARTY
        end
    end
end)

m:addOverride(string.format('xi.actions.spells.trust.%s.onMobDeath', trustToReplaceName), function(mob)
    -- Intentionally blank
end)

return m
