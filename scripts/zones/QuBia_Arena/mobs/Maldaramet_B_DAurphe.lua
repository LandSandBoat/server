-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Maldaramet B D'Aurphe
-- BCNM: Brothers D'Aurphe
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 7)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 7)
    mob:setMod(xi.mod.REGAIN, 100)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 15)
    mob:setMobMod(xi.mobMod.STANDBACK_COOL, 5)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.DRAIN,
        xi.magic.spell.BLIZZARD_III,
        xi.magic.spell.WATER_III,
        xi.magic.spell.FIRE_III,
        xi.magic.spell.STONEGA_III,
        xi.magic.spell.THUNDAGA_II,
    }

    if target:getMP() > 0 then
        table.insert(spellList, xi.magic.spell.ASPIR)
    end

    if not target:hasStatusEffect(xi.effect.BLINDNESS) then
        table.insert(spellList, xi.magic.spell.BLIND)
    end

    if not target:hasStatusEffect(xi.effect.POISON) then
        table.insert(spellList, xi.magic.spell.POISON_II)
    end

    if not target:hasStatusEffect(xi.effect.BIO) then
        table.insert(spellList, xi.magic.spell.BIO_II)
    end

    if not target:hasStatusEffect(xi.effect.SLEEP_I) then
        table.insert(spellList, xi.magic.spell.SLEEP)
    end

    if not target:hasStatusEffect(xi.effect.BIND) then
        table.insert(spellList, xi.magic.spell.BIND)
    end

    if target:hasStatusEffectByFlag(xi.effectFlag.DISPELABLE) then
        table.insert(spellList, xi.magic.spell.DISPEL)
    end

    return spellList[math.random(1, #spellList)]
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.EVASION_DOWN)
end

return entity
