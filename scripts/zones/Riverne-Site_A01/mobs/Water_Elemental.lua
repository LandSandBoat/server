-----------------------------------
-- Area: Riverne - Site A01
-- Mob: Water Elemental
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
        [1] = { xi.magic.spell.WATER_IV,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                0, 100 },
        [2] = { xi.magic.spell.WATERGA_III, target, false, xi.action.type.DAMAGE_TARGET,        nil,                0, 100 },
        [3] = { xi.magic.spell.FLOOD,       target, false, xi.action.type.DAMAGE_TARGET,        nil,                0, 100 },
        [4] = { xi.magic.spell.DROWN,       target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.DROWN,    0, 100 },
        [5] = { xi.magic.spell.POISONGA_II, target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.POISON,   0, 100 },
        [6] = { xi.magic.spell.AQUAVEIL,    mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.AQUAVEIL, 0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
