-----------------------------------
-- Area: Bibiki Bay
--  Mob: Shen's Filtrate
-- Note: Shen Elemental
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGEN, 120)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.POISON)
    mob:setMobMod(xi.mobMod.SKIP_ALLEGIANCE_CHECK, 1)
    mob:setMagicCastingEnabled(false) -- Stay silent until engaged so the spellList (1) can't fire while approaching its target.
    mob:setLocalVar('floodCooldown', GetSystemTime() + 30) -- First Flood ~30s after spawn; 45s between casts thereafter.
end

entity.onMobEngage = function(mob, target)
    mob:setMagicCastingEnabled(true)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    if GetSystemTime() >= mob:getLocalVar('floodCooldown') then
        mob:setMod(xi.mod.UFASTCAST, 100)
        mob:setLocalVar('floodCooldown', GetSystemTime() + 45)
        return xi.magic.spell.FLOOD
    end

    mob:setMod(xi.mod.UFASTCAST, 0)

    local spellList =
    {
        [1] = { xi.magic.spell.WATER_III,   target, false, xi.action.type.DAMAGE_TARGET,     nil,             0, 100 },
        [2] = { xi.magic.spell.WATER_IV,    target, false, xi.action.type.DAMAGE_TARGET,     nil,             0, 100 },
        [3] = { xi.magic.spell.WATERGA_III, target, false, xi.action.type.DAMAGE_TARGET,     nil,             0, 100 },
        [4] = { xi.magic.spell.DROWN,       target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.DROWN, 0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onMobDisengage = function(mob)
    mob:setMagicCastingEnabled(false)
end

return entity
