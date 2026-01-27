-----------------------------------
-- Area : Balga's Dais
-- Mob  : Gii Jaha the Raucous
-- BCNM : Divine Punishers
-- Job  : BRD
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 4)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 4)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.FOE_REQUIEM_V,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.REQUIEM, 0, 100 },
        [2] = { xi.magic.spell.BATTLEFIELD_ELEGY, target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.ELEGY,   0, 100 },
        [3] = { xi.magic.spell.QUICK_ETUDE,       mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.ETUDE,   0, 100 },
        [4] = { xi.magic.spell.DEXTROUS_ETUDE,    mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.ETUDE,   0, 100 },
        [5] = { xi.magic.spell.VALOR_MINUET_IV,   mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.MINUET,  0, 100 },
        [6] = { xi.magic.spell.KNIGHTS_MINNE_IV,  mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.MINNE,   0, 100 },
        [7] = { xi.magic.spell.VICTORY_MARCH,     mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.MARCH,   0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
