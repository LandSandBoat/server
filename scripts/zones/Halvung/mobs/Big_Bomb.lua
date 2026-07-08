-----------------------------------
-- Area: Halvung
-- NM: Big Bomb
-----------------------------------
mixins = { require('scripts/mixins/families/growing_bomb') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 9)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.POWER_MULTIPLIER_SPELL, 10)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.BURN,         target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.BURN,         0, 100 },
        [2] = { xi.magic.spell.FLARE,        target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [3] = { xi.magic.spell.FIRAGA_III,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [4] = { xi.magic.spell.FIRE_IV,      target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [5] = { xi.magic.spell.BLAZE_SPIKES, mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.BLAZE_SPIKES, 0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    return xi.mix.growingBomb.onMobMobskillChoose(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 466)
end

return entity
