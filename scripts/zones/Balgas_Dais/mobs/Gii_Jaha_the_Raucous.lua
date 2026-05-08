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
        [1] = { spellId = xi.magic.spell.FOE_REQUIEM_V     },
        [2] = { spellId = xi.magic.spell.BATTLEFIELD_ELEGY },
        [3] = { spellId = xi.magic.spell.QUICK_ETUDE       },
        [4] = { spellId = xi.magic.spell.DEXTROUS_ETUDE    },
        [5] = { spellId = xi.magic.spell.VALOR_MINUET_IV   },
        [6] = { spellId = xi.magic.spell.KNIGHTS_MINNE_IV  },
        [7] = { spellId = xi.magic.spell.VICTORY_MARCH     },
    }

    return xi.combat.behavior.chooseSpell(mob, target, spellList, nil, nil)
end

return entity
