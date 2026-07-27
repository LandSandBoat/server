-----------------------------------
-- Area: Behemoths Dominion
--   NM: Legendary Weapon
-----------------------------------
local ID = zones[xi.zone.BEHEMOTHS_DOMINION]
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.MATT, 20)
    mob:setMod(xi.mod.UDMGMAGIC, -1300)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.PROTECT_IV, mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.PROTECT,   0, 100 },
        [ 2] = { xi.magic.spell.SHELL_III,  mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.SHELL,     0, 100 },
        [ 3] = { xi.magic.spell.HASTE,      mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.HASTE,     5, 100 },
        [ 4] = { xi.magic.spell.BLINK,      mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.BLINK,     0, 100 },
        [ 5] = { xi.magic.spell.STONESKIN,  mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.STONESKIN, 0, 100 },
        [ 6] = { xi.magic.spell.AQUAVEIL,   mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.AQUAVEIL,  0, 100 },
        [ 7] = { xi.magic.spell.ENWATER,    mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.ENWATER,   0, 100 },
        [ 8] = { xi.magic.spell.CURE_IV,    mob,    true,  xi.action.type.HEALING_TARGET,    33,                  0, 100 },
        [ 9] = { xi.magic.spell.DIA_II,     target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.DIA,       3, 100 },
        [10] = { xi.magic.spell.DIAGA_II,   target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.DIA,       3, 100 },
        [11] = { xi.magic.spell.BIO_II,     target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIO,       4, 100 },
        [12] = { xi.magic.spell.POISON_II,  target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.POISON,    0, 100 },
        [13] = { xi.magic.spell.BLIND,      target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BLINDNESS, 0, 100 },
        [14] = { xi.magic.spell.PARALYZE,   target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.PARALYSIS, 0, 100 },
        [15] = { xi.magic.spell.BIND,       target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIND,      0, 100 },
        [16] = { xi.magic.spell.SLEEP,      target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLEEP_I,   1,  25 },
        [17] = { xi.magic.spell.SLEEP_II,   target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLEEP_I,   2, 100 },
        [18] = { xi.magic.spell.FIRE_II,    target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100 },
        [19] = { xi.magic.spell.WATER_II,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100 },
        [20] = { xi.magic.spell.AERO_II,    target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100 },
        [21] = { xi.magic.spell.THUNDER_II, target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100 },
        [22] = { xi.magic.spell.STONE_III,  target, false, xi.action.type.DAMAGE_TARGET,     nil,                 0, 100 },
    }

    -- It cures the Ancient Weapon as well as itself.
    return xi.combat.behavior.chooseAction(mob, target, { GetMobByID(ID.mob.ANCIENT_WEAPON) }, spellList)
end

entity.onMobDisengage = function(mob)
    DespawnMob(mob:getID(), 120)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 102, 2, xi.regime.type.FIELDS)

    if optParams.isKiller or optParams.noKiller then
        local headstone     = GetNPCByID(ID.npc.CERMET_HEADSTONE)
        local ancientWeapon = GetMobByID(ID.mob.ANCIENT_WEAPON)

        if
            headstone and
            ancientWeapon and
            ancientWeapon:isDead()
        then
            headstone:setLocalVar('cooldown', GetSystemTime() + 900)
        end
    end
end

return entity
