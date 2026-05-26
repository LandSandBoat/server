-----------------------------------
-- Area: Balgas Dais
--  Mob: King of Cups (WHM)
-- KSNM: Royale Ramble
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.PARALYZE)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 40)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 25)
end

entity.onMobEngage = function(mob, target)
    -- When King of Cups is engaged, the other three kings despawn & the two queens spawn.
    local mobId = mob:getID()
    DespawnMob(mobId + 1) -- King of Batons
    DespawnMob(mobId + 2) -- King of Swords
    DespawnMob(mobId + 3) -- King of Coins
    SpawnMob(mobId + 4)   -- Queen of Cups
    SpawnMob(mobId + 5)   -- Queen of Batons
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ABSORB_STATUS)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { spellId = xi.magic.spell.BANISH_III                        },
        [ 2] = { spellId = xi.magic.spell.BANISHGA_III                      },
        [ 3] = { spellId = xi.magic.spell.HOLY                              },
        [ 4] = { spellId = xi.magic.spell.DIA_II                            },
        [ 5] = { spellId = xi.magic.spell.DIAGA_II                          },
        [ 6] = { spellId = xi.magic.spell.PARALYZE                          },
        [ 7] = { spellId = xi.magic.spell.SLOW                              },
        [ 8] = { spellId = xi.magic.spell.SILENCE                           },
        [ 9] = { spellId = xi.magic.spell.BLINK                             },
        [10] = { spellId = xi.magic.spell.STONESKIN                         },
        [11] = { spellId = xi.magic.spell.AQUAVEIL                          },
        [12] = { spellId = xi.magic.spell.HASTE                             },
        [13] = { spellId = xi.magic.spell.PROTECT_IV,  weight = 25          },
        [14] = { spellId = xi.magic.spell.SHELL_IV,    weight = 25          },
        [15] = { spellId = xi.magic.spell.POISONA                           },
        [16] = { spellId = xi.magic.spell.BLINDNA                           },
        [17] = { spellId = xi.magic.spell.PARALYNA                          },
        [18] = { spellId = xi.magic.spell.POISONA                           },
        [19] = { spellId = xi.magic.spell.SILENA                            },
        [20] = { spellId = xi.magic.spell.VIRUNA                            },
        [21] = { spellId = xi.magic.spell.VIRUNA                            },
        [22] = { spellId = xi.magic.spell.CURE_V,      hpp = 33             },
        [23] = { spellId = xi.magic.spell.ERASE,       evaluateErase = true },
    }

    local allyList =
    {
        GetMobByID(mob:getID() + 4), -- Queen of Cups
        GetMobByID(mob:getID() + 5), -- Queen of Batons
    }

    return xi.combat.behavior.chooseSpell(mob, target, spellList, allyList, nil)
end

return entity
