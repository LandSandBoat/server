-----------------------------------
-- Functions that return an integer value meant to be additive.
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.damage = xi.combat.damage or {}
-----------------------------------

xi.combat.damage.souleaterAddition = function(actor)
    -- http://wiki.ffo.jp/html/1705.html
    -- https://www.ffxiah.com/forum/topic/21497/stalwart-soul/ some anecdotal data that aligns with JP
    -- https://www.bg-wiki.com/ffxi/Agwu%27s_Scythe Souleater Effect that goes beyond established cap, Stalwart Soul bonus being additive to trait

    if not actor:hasStatusEffect(xi.effect.SOULEATER) then
        return 0
    end

    local souleaterEffect        = actor:getMaxGearMod(xi.mod.SOULEATER_EFFECT) / 100
    local souleaterEffectII      = actor:getMod(xi.mod.SOULEATER_EFFECT_II) / 100
    local stalwartSoulMultiplier = 1 - actor:getMod(xi.mod.STALWART_SOUL) / 100
    local bonusDamage            = math.floor(actor:getHP() * (0.1 + souleaterEffect + souleaterEffectII))

    if bonusDamage > 0 then
        local selfDamage = bonusDamage * stalwartSoulMultiplier

        selfDamage = utils.handleStoneskin(actor, selfDamage)

        actor:delHP(selfDamage)

        if actor:getMainJob() ~= xi.job.DRK then
            return math.floor(bonusDamage / 2)
        end
    end

    return bonusDamage
end

xi.combat.damage.consumeManaAddition = function(actor)
    if not actor:hasStatusEffect(xi.effect.CONSUME_MANA) then
        return 0
    end

    local bonusDamage = math.floor(actor:getMP() / 10)
    actor:setMP(0)
    actor:delStatusEffect(xi.effect.CONSUME_MANA)

    return bonusDamage
end
