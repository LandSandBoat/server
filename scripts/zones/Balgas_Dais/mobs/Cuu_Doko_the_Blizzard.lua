-----------------------------------
-- Area : Balga's Dais
-- Mob  : Cuu Doko the Blizzard
-- BCNM : Divine Punishers
-- Job  : WHM
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

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobSpellChoose = function(mob, target)
    local spellList =
    {
        [ 1] = { spellId = xi.magic.spell.BANISH_II                },
        [ 2] = { spellId = xi.magic.spell.CURE_V,      hpp = 33    },
        [ 3] = { spellId = xi.magic.spell.CURAGA_II,   hpp = 33    },
        [ 4] = { spellId = xi.magic.spell.BLINDNA                  },
        [ 5] = { spellId = xi.magic.spell.PARALYNA                 },
        [ 6] = { spellId = xi.magic.spell.POISONA                  },
        [ 7] = { spellId = xi.magic.spell.SILENA                   },
        [ 8] = { spellId = xi.magic.spell.VIRUNA                   },
        [ 9] = { spellId = xi.magic.spell.VIRUNA                   },
        [10] = { spellId = xi.magic.spell.AQUAVEIL                 },
        [11] = { spellId = xi.magic.spell.HASTE                    },
        [12] = { spellId = xi.magic.spell.PROTECT_III, weight = 25 },
        [13] = { spellId = xi.magic.spell.SHELL_III,   weight = 25 },
        [14] = { spellId = xi.magic.spell.DIA_II                   },
        [15] = { spellId = xi.magic.spell.PARALYZE                 },
        [16] = { spellId = xi.magic.spell.SILENCE                  },
    }

    local allyList =
    {
        GetMobByID(mob:getID() - 1), -- Voo Tolu the Ghostfist
        GetMobByID(mob:getID() + 1), -- Zuu Xowu the Darksmoke
        GetMobByID(mob:getID() + 2), -- Gii Jaha the Raucous
        GetMobByID(mob:getID() + 3), -- Aa Nawu the Thunderblade
        GetMobByID(mob:getID() + 4), -- Yoo Mihi the Haze
    }

    return xi.combat.behavior.chooseSpell(mob, target, spellList, allyList, nil)
end

return entity
