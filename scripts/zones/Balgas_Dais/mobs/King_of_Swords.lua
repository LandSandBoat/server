-----------------------------------
-- Area: Balgas Dais
--  Mob: King of Swords (PLD)
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
    -- When King of Swords is engaged, the other three kings despawn & the two queens spawn.
    local mobId = mob:getID()
    DespawnMob(mobId - 2) -- King of Cups
    DespawnMob(mobId - 1) -- King of Batons
    DespawnMob(mobId + 1) -- King of Coins
    SpawnMob(mobId + 2)   -- Queen of Cups
    SpawnMob(mobId + 3)   -- Queen of Batons
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ATTACK_DOWN)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { spellId = xi.magic.spell.BANISH_II           },
        [2] = { spellId = xi.magic.spell.FLASH               },
        [3] = { spellId = xi.magic.spell.PROTECT_IV          },
        [4] = { spellId = xi.magic.spell.SHELL_III           },
        [5] = { spellId = xi.magic.spell.CURE_IV,   hpp = 33 },
    }

    local allyList =
    {
        GetMobByID(mob:getID() + 2), -- Queen of Cups
        GetMobByID(mob:getID() + 3), -- Queen of Batons
    }

    return xi.combat.behavior.chooseSpell(mob, target, spellList, allyList, nil)
end

return entity
