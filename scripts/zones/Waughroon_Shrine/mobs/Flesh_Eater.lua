-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Flesh Eater
-- BCNM: The Worm's Turn
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.CHARMABLE, 1)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.STONE_II,  target, false, xi.action.type.DAMAGE_TARGET,     nil,                 100 },
        [2] = { xi.magic.spell.STONEGA,   target, false, xi.action.type.DAMAGE_TARGET,     nil,                 100 },
        [3] = { xi.magic.spell.RASP,      target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.RASP,      100 },
        [4] = { xi.magic.spell.BIND,      target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.BIND,      100 },
        [5] = { xi.magic.spell.STONESKIN, mob,    false, xi.action.type.ENHANCING_TARGET,  xi.effect.STONESKIN, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
