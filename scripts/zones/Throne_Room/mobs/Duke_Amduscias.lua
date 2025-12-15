-----------------------------------
-- Area : Throne Room
-- Mob  : Duke Amduscias
-- BCNM : Kindred Spirits
-- Job  : Black Mage
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 6)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 7)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.FLARE,
        xi.magic.spell.FLOOD,
        xi.magic.spell.FIRAGA_II,
        xi.magic.spell.FIRE_III,
        xi.magic.spell.AERO_III,
        xi.magic.spell.THUNDAGA_II,
        xi.magic.spell.DRAIN,
    }

    if not mob:hasStatusEffect(xi.effect.BLAZE_SPIKES) then
        table.insert(spellList, xi.magic.spell.BLAZE_SPIKES)
    end

    if not target:hasStatusEffect(xi.effect.BURN) then
        table.insert(spellList, xi.magic.spell.BURN)
    end

    if not target:hasStatusEffect(xi.effect.SHOCK) then
        table.insert(spellList, xi.magic.spell.SHOCK)
    end

    if not target:hasStatusEffect(xi.effect.CHOKE) then
        table.insert(spellList, xi.magic.spell.CHOKE)
    end

    if not target:hasStatusEffect(xi.effect.SLEEP_II) then
        table.insert(spellList, xi.magic.spell.SLEEPGA_II)
    end

    if not target:hasStatusEffect(xi.effect.BIO) then
        table.insert(spellList, xi.magic.spell.BIO_II)
    end

    if target:getMP() > 0 then
        table.insert(spellList, xi.magic.spell.ASPIR)
    end

    return spellList[math.random(1, #spellList)]
end

return entity
