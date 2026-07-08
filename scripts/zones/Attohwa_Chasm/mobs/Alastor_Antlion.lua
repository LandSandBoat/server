-----------------------------------
-- Area: Attohwa Chasm
--   NM: Alastor Antlion
-----------------------------------
local ID = zones[xi.zone.ATTOHWA_CHASM]
mixins = { require('scripts/mixins/families/antlion_ambush_no_rehide') }
local attohwaChasmGlobal = require('scripts/zones/Attohwa_Chasm/globals')
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.GA_CHANCE, 50) -- Needs verification
    mob:setMobMod(xi.mobMod.GIL_MIN, 18000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 18000)
    mob:setMobMod(xi.mobMod.MUG_GIL, 10000) -- Needs verification
    mob:addMod(xi.mod.FASTCAST, 10) -- Needs verification

    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.ELEGY)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 50)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PETRIFY)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.STONESKIN,   mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.STONESKIN,     0, 100 },
        [ 2] = { xi.magic.spell.BREAKGA,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.PETRIFICATION, 0, 100 },
        [ 3] = { xi.magic.spell.STONEGA_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                     0, 100 },
        [ 4] = { xi.magic.spell.STONE_IV,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                     0, 100 },
        [ 5] = { xi.magic.spell.QUAKE,       target, false, xi.action.type.DAMAGE_TARGET,        nil,                     0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onMobDespawn = function(mob)
    local feelerAntlionQM = GetNPCByID(ID.npc.QM_FEELER_ANTLION)
    if
        feelerAntlionQM and
        attohwaChasmGlobal.canStartFeelerQMTimer()
    then
        feelerAntlionQM:updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
    end
end

return entity
