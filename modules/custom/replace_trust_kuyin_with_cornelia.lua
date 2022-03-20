-----------------------------------
-- Replace Trust: Kuyin Hathdenna with Trust: Cornelia
--
-- The name of the spell itself can't be changed (would require client changes),
-- but everything else can be changed!
-----------------------------------
require("modules/module_utils")
require("scripts/globals/trust")
-----------------------------------
local m = Module:new("replace_trust_kuyin_with_cornelia")
m:setEnabled(false)

m:addOverride("xi.globals.spells.trust.kuyin_hathdenna.onSpellCast", function(caster, target, spell)
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
    trust:setModelId(70) -- Cornelia
    trust:setPacketName("Cornelia")

    local boostAmount = math.ceil((30 / 99) * caster:getMainLvl())
    trust:addStatusEffectEx(xi.effect.GEO_HASTE, xi.effect.GEO_HASTE, 6, 3, 0, xi.effect.GEO_HASTE, boostAmount, xi.auraTarget.ALLIES, xi.effectFlag.AURA)
    trust:addStatusEffectEx(xi.effect.GEO_ACCURACY_BOOST, xi.effect.GEO_ACCURACY_BOOST, 6, 3, 0, xi.effect.GEO_ACCURACY_BOOST, boostAmount, xi.auraTarget.ALLIES, xi.effectFlag.AURA)
    trust:addStatusEffectEx(xi.effect.GEO_MAGIC_ACC_BOOST, xi.effect.GEO_MAGIC_ACC_BOOST, 6, 3, 0, xi.effect.GEO_MAGIC_ACC_BOOST, boostAmount, xi.auraTarget.ALLIES, xi.effectFlag.AURA)
    -- TODO: Ranged accuracy boost

    trust:SetAutoAttackEnabled(false)
    trust:setUnkillable(true)
end)

m:addOverride("xi.globals.spells.trust.kuyin_hathdenna.onMobSpawn", function(mob)
    for _, member in ipairs(mob:getMaster():getParty()) do
        if member:isPC() then
            member:PrintToPlayer("Cornelia, at your service.", 4, "Cornelia") -- 4: MESSAGE_PARTY
        end
    end
end)

m:addOverride("xi.globals.spells.trust.kuyin_hathdenna.onMobDespawn", function(mob)
    for _, member in ipairs(mob:getMaster():getParty()) do
        if member:isPC() then
            member:PrintToPlayer("Remember: never give up!", 4, "Cornelia") -- 4: MESSAGE_PARTY
        end
    end
end)

m:addOverride("xi.globals.spells.trust.kuyin_hathdenna.onMobDeath", function(mob)
    -- Intentionally blank
end)

return m
