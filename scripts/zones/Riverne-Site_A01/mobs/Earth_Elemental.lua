-----------------------------------
-- Area: Riverne - Site A01
-- Mob: Earth Elemental
-- Notes: in Ouryu Cometh
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 500)
    mob:setMobMod(xi.mobMod.NO_DROPS, 1)
    mob:setRoamFlags(xi.roamFlag.NONE)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.STONE_IV,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [2] = { xi.magic.spell.STONEGA_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [3] = { xi.magic.spell.QUAKE,       target, false, xi.action.type.DAMAGE_TARGET,        nil,                 0, 100 },
        [4] = { xi.magic.spell.RASP,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.RASP,      0, 100 },
        [5] = { xi.magic.spell.SLOW,        target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLOW,      3, 100 },
        [6] = { xi.magic.spell.STONESKIN,   mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.STONESKIN, 0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
