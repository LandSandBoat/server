-----------------------------------
-- Area: Balgas Dais
--  Mob: King of Coins (RDM)
-- KSNM: Royale Ramble
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PARALYZE)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 25)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 40)
end

entity.onMobEngage = function(mob, target)
    -- When King of Coins is engaged, the other three kings despawn & the two queens spawn.
    local mobId = mob:getID()
    DespawnMob(mobId - 3) -- King of Cups
    DespawnMob(mobId - 2) -- King of Batons
    DespawnMob(mobId - 1) -- King of Swords
    SpawnMob(mobId + 1)   -- Queen of Cups
    SpawnMob(mobId + 2)   -- Queen of Batons
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance  = 25,
        element = xi.element.DARK,
    }

    return xi.combat.action.executeAddEffectDispel(mob, target, pTable)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { spellId = xi.magic.spell.FIRE_III                            },
        [ 2] = { spellId = xi.magic.spell.BLIZZARD_III                        },
        [ 3] = { spellId = xi.magic.spell.AERO_III                            },
        [ 4] = { spellId = xi.magic.spell.WATER_III                           },
        [ 5] = { spellId = xi.magic.spell.THUNDER_III                         },
        [ 6] = { spellId = xi.magic.spell.STONE_IV                            },
        [ 7] = { spellId = xi.magic.spell.BIO_III                             },
        [ 8] = { spellId = xi.magic.spell.POISON_II                           },
        [ 9] = { spellId = xi.magic.spell.DIA_II                              },
        [10] = { spellId = xi.magic.spell.DIAGA_II                            },
        [11] = { spellId = xi.magic.spell.BIND                                },
        [12] = { spellId = xi.magic.spell.GRAVITY                             },
        [13] = { spellId = xi.magic.spell.SLEEP                               },
        [14] = { spellId = xi.magic.spell.SLEEP_II                            },
        [15] = { spellId = xi.magic.spell.SLOW                                },
        [16] = { spellId = xi.magic.spell.PARALYZE                            },
        [17] = { spellId = xi.magic.spell.BLIND                               },
        [18] = { spellId = xi.magic.spell.BLINK                               },
        [19] = { spellId = xi.magic.spell.STONESKIN                           },
        [20] = { spellId = xi.magic.spell.AQUAVEIL                            },
        [21] = { spellId = xi.magic.spell.ENWATER                             },
        [22] = { spellId = xi.magic.spell.PROTECT_IV                          },
        [23] = { spellId = xi.magic.spell.SHELL_IV                            },
        [24] = { spellId = xi.magic.spell.HASTE                               },
        [25] = { spellId = xi.magic.spell.REGEN                               },
        [26] = { spellId = xi.magic.spell.CURE_IV,      hpp = 33              },
        [27] = { spellId = xi.magic.spell.DISPEL,       evaluateDispel = true },
    }

    local allyList =
    {
        GetMobByID(mob:getID() + 1), -- Queen of Cups
        GetMobByID(mob:getID() + 2), -- Queen of Batons
    }

    return xi.combat.behavior.chooseSpell(mob, target, spellList, allyList, nil)
end

return entity
