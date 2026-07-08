-----------------------------------
-- Area: Oldton Movalpolos
--  Mob: Moblin Gurneyman
-----------------------------------
---@type TMobEntity
local entity = {}

-- TODO: Casts often when not engaged. Need further research into roaming/buff cast timings.

entity.onMobSpellChoose = function(mob, target)
    local spellList = {}

    local spellListIdle =
    {
        -- Will recast spells when out of combat with no regard to if it has the effect already.
        [1] = { xi.magic.spell.HASTEGA,      target, false, xi.action.type.ENHANCING_FORCE_SELF,  0, 5, 100 },
        [2] = { xi.magic.spell.BARSILENCERA, target, false, xi.action.type.ENHANCING_FORCE_SELF,  0, 1, 100 },
        [3] = { xi.magic.spell.BARSLEEPRA,   target, false, xi.action.type.ENHANCING_FORCE_SELF,  0, 1, 100 },
        [4] = { xi.magic.spell.PROTECTRA_IV, target, false, xi.action.type.ENHANCING_FORCE_SELF,  0, 4, 100 },
        [5] = { xi.magic.spell.SHELLRA_IV,   target, false, xi.action.type.ENHANCING_FORCE_SELF,  0, 4, 100 },
    }

    -- TODO: From retail captures:
    --       Captures were done over 6+ hours in a single session.
    --       For some reason the mob does not cast most enfeebles on Trusts. It cast Poison II, Dia II, and Bio III when targeting a tank trust.
    --       Once player took hate off the trust, the mob immediatly started casting the following on the player: Bind, Gravity, Paralyze, Sleep I & II, Slow.
    --       This was seen on regular moblins as well. Needs more research across different zones/mobs to see if its unique or a baseline behavior.

    local spellListCombat =
    {
        [1] = { xi.magic.spell.AERO_II,     target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [2] = { xi.magic.spell.AQUAVEIL,    target, false, xi.action.type.ENHANCING_TARGET,  xi.effect.AQUAVEIL,   1, 100 },
        [3] = { xi.magic.spell.BIND,        target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIND,       1, 100 },
        [4] = { xi.magic.spell.BIO_II,      target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIO,        3, 100 },
        [5] = { xi.magic.spell.BLINK,       target, false, xi.action.type.ENHANCING_TARGET,  xi.effect.BLINK,      0, 100 },
        [6] = { xi.magic.spell.BLIND,       target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BLINDNESS,  1, 100 },
        [7] = { xi.magic.spell.BLIZZARD,    target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [8] = { xi.magic.spell.CURE_III,    target, true, xi.action.type.HEALING_TARGET,     33,                   0, 100 },
        [9] = { xi.magic.spell.DIA_II,      target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.DIA,        3, 100 },
        [10] = { xi.magic.spell.DIAGA_II,   target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.DIA,        3, 100 },
        [11] = { xi.magic.spell.DISPEL,     target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [12] = { xi.magic.spell.ENWATER,    target, false, xi.action.type.ENHANCING_TARGET,  xi.effect.ENWATER,    1, 100 },
        [13] = { xi.magic.spell.FIRE,       target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [14] = { xi.magic.spell.GRAVITY,    target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.WEIGHT,     1, 100 },
        [15] = { xi.magic.spell.PARALYZE,   target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.PARALYSIS,  0, 100 },
        [16] = { xi.magic.spell.POISON_II,  target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.POISON,     2, 100 },
        [17] = { xi.magic.spell.REGEN,      target, true,  xi.action.type.ENHANCING_TARGET,  xi.effect.REGEN,      1, 100 },
        [18] = { xi.magic.spell.SHELL_II,   target, true,  xi.action.type.ENHANCING_TARGET,  xi.effect.SHELL,      2, 100 },
        [19] = { xi.magic.spell.SLEEP,      target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLEEP_I,    1, 100 },
        [20] = { xi.magic.spell.SLEEP_II,   target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLEEP_I,   2, 100 },
        [21] = { xi.magic.spell.SLOW,       target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLOW,       3, 100 },
        [22] = { xi.magic.spell.STONE_II,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [23] = { xi.magic.spell.STONESKIN,  target, false, xi.action.type.ENHANCING_TARGET,  xi.effect.STONESKIN,  0, 100 },
        [24] = { xi.magic.spell.THUNDER,    target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
        [25] = { xi.magic.spell.WATER_II,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                  0, 100 },
    }

    -- Protect II upgrades to Protect III if the mob is level 47.
    if mob:getMainLvl() >= 47 then
        table.insert(spellListCombat, { xi.magic.spell.PROTECT_III, target, true, xi.action.type.ENHANCING_TARGET, xi.effect.PROTECT, 3, 100 })
    else
        table.insert(spellListCombat, { xi.magic.spell.PROTECT_II, target, true, xi.action.type.ENHANCING_TARGET, xi.effect.PROTECT, 2, 100 })
    end

    if mob:isEngaged() then
        spellList = spellListCombat
    else
        spellList = spellListIdle
    end

    -- Moblin will buff other goblins while it is in combat, even if the others are not engaged or linked.
    local mobParty = {}

    for _, member in ipairs(mob:getParty()) do
        if
            member and
            member:getID() ~= mob:getID() and
            member:isAlive() and
            member:checkDistance(mob) < 8
        then
            table.insert(mobParty, member)
        end
    end

    return xi.combat.behavior.chooseAction(mob, target, mobParty, spellList)
end

return entity
