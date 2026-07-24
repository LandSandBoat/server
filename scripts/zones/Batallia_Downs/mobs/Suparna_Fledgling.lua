-----------------------------------
-- Area: Batallia Downs
--  Mob: Suparna Fledgling
-- Mission 9-1 San d'Oria
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.PETRIFY)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 200)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 10)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 10)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 6)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.HORDE_LULLABY,  target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLEEP_I, 1, 100 },
        [2] = { xi.magic.spell.MASSACRE_ELEGY, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.ELEGY,   1, 100 },
        [3] = { xi.magic.spell.MAGIC_FINALE,   target, false, xi.action.type.NONE,              nil,               0,  50 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
