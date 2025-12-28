-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Ix'aern DRG's Wynav
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.BIND)

    xi.mix.jobSpecial.config(mob, { specials = { { id = xi.jsa.SOUL_VOICE, hpp = math.random(10, 75) } } })
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.ARMYS_PAEON_V,
        xi.magic.spell.HORDE_LULLABY,
        xi.magic.spell.FOE_REQUIEM_V,
        xi.magic.spell.KNIGHTS_MINNE_IV,
        xi.magic.spell.VALOR_MINUET_IV,
        xi.magic.spell.BLADE_MADRIGAL,
        xi.magic.spell.CARNAGE_ELEGY,
        xi.magic.spell.MAGIC_FINALE,
    }

    if mob:hasStatusEffect(xi.effect.SOUL_VOICE) then
        -- Virelai possible.
        table.insert(spellList, xi.magic.spell.MAIDENS_VIRELAI)
    end

    return utils.randomEntry(spellList)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    mob:setLocalVar('repop', GetSystemTime() + 10)
end

return entity
