-----------------------------------
-- Area: Balgas Dais
--  Mob: King of Batons (BLM)
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
    -- When King of Batons is engaged, the other three kings despawn & the two queens spawn.
    local mobId = mob:getID()
    DespawnMob(mobId - 1) -- King of Cups
    DespawnMob(mobId + 1) -- King of Swords
    DespawnMob(mobId + 2) -- King of Coins
    SpawnMob(mobId + 3)   -- Queen of Cups
    SpawnMob(mobId + 4)   -- Queen of Batons
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.HP_DRAIN, { power = math.random(25, 125) })
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { spellId = xi.magic.spell.FIRE_IV                                           },
        [ 2] = { spellId = xi.magic.spell.BLIZZARD_IV                                       },
        [ 3] = { spellId = xi.magic.spell.AERO_IV                                           },
        [ 4] = { spellId = xi.magic.spell.THUNDER_IV                                        },
        [ 5] = { spellId = xi.magic.spell.WATER_IV                                          },
        [ 6] = { spellId = xi.magic.spell.FIRAGA_III                                        },
        [ 7] = { spellId = xi.magic.spell.THUNDAGA_III                                      },
        [ 8] = { spellId = xi.magic.spell.DRAIN,                      evaluateUndead = true },
        [ 9] = { spellId = xi.magic.spell.ASPIR,          mp = 1,     evaluateUndead = true },
        [10] = { spellId = xi.magic.spell.STUN                                              },
        [11] = { spellId = xi.magic.spell.BLIND                                             },
        [12] = { spellId = xi.magic.spell.BIND                                              },
        [13] = { spellId = xi.magic.spell.BURN                                              },
        [14] = { spellId = xi.magic.spell.SHOCK                                             },
        [15] = { spellId = xi.magic.spell.CHOKE                                             },
        [16] = { spellId = xi.magic.spell.BIO_II                                            },
        [17] = { spellId = xi.magic.spell.POISONGA_II                                       },
        [18] = { spellId = xi.magic.spell.SLEEP,          weight = 50                       },
        [19] = { spellId = xi.magic.spell.SLEEP_II,       weight = 50                       },
        [20] = { spellId = xi.magic.spell.SLEEPGA,        weight = 50                       },
        [21] = { spellId = xi.magic.spell.SLEEPGA_II,     weight = 50                       },
        [22] = { spellId = xi.magic.spell.BLAZE_SPIKES                                      },
    }

    return xi.combat.behavior.chooseSpell(mob, target, spellList, nil, nil)
end

return entity
