-----------------------------------
-- Area: Balga's Dais
--  Mob: Ulagohvsdi Tlugvi (NIN) "Autumn Tree"
-- BCNM: Season's Greetings
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

-- TODO: Enfeeble and elemental resistances over time.
-- TODO: EEM
-- TODO: Ninjutsu resistances
-- TODO: Song resistances
-- TODO: Bonus damage trigger conditions (doesn't seem to be related to crits or 2HR)
-- TODO: TP move characteristics (like AOE type). Update the TP move lua file if necessary.
-- TODO: Check if the next tree is already aggroed and targeting someone else, does it switch to the 2HR'ing mobs target?

local elementalNinjutsuWeights =
{
    { id = xi.magic.spell.DOTON_NI,  chance = 15 },
    { id = xi.magic.spell.HUTON_NI,  chance = 40 },
    { id = xi.magic.spell.HYOTON_NI, chance = 5  },
    { id = xi.magic.spell.KATON_NI,  chance = 5  },
    { id = xi.magic.spell.RAITON_NI, chance = 20 },
    { id = xi.magic.spell.SUITON_NI, chance = 15 },
}

local enfeebleNinjutsuWeights =
{
    { id = xi.magic.spell.KURAYAMI_NI, chance = 15 },
    { id = xi.magic.spell.DOKUMORI_NI, chance = 50 },
    { id = xi.magic.spell.HOJO_NI,     chance = 25 },
    { id = xi.magic.spell.JUBAKU_NI,   chance = 10 },
}

-----------------------------------
-- Reroll spells with proper weights.
-----------------------------------
local reRollActionWeights = function(weights)
    local abilityRoll    = math.random(1, 100)
    local probabilitySum = 0

    for _, skill in ipairs(weights) do
        probabilitySum = probabilitySum + skill.chance

        if abilityRoll <= probabilitySum then
            return skill.id
        end
    end

    return 0
end

-----------------------------------
-- Enable additional effects on melee.
-----------------------------------
entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

-----------------------------------
-- Sets initial mob-specific immunities.
-----------------------------------
entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
end

-----------------------------------
-- Additional effect: Paralyze
-----------------------------------
entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PARALYZE, { chance = 15, duration = math.random(30, 60) })
end

-----------------------------------
-- Ninjutsu usage is not evenly distributed.
-----------------------------------
entity.onMobMagicPrepare = function(mob, target, spell)
    local spellID = spell:getID()

    -- If we're casting elemental ninjutsu then follow the weights.
    for _, spellData in ipairs(elementalNinjutsuWeights) do
        if spellData.id == spellID then
            return reRollActionWeights(elementalNinjutsuWeights)
        end
    end

    -- If we're casting enfeebling ninjutsu then follow the weights.
    for _, spellData in ipairs(enfeebleNinjutsuWeights) do
        if spellData.id == spellID then
            return reRollActionWeights(enfeebleNinjutsuWeights)
        end
    end

    return spellID
end

-----------------------------------
-- Only uses one TP move.
-----------------------------------
entity.onMobWeaponSkillPrepare = function(mob, target)
    return xi.mobSkill.PINECONE_BOMB
end

-----------------------------------
-- Using 2-Hour causes the next tree to engage the player.
-----------------------------------
entity.onMobWeaponSkill = function(target, mob, skill)
    local skillID = skill:getID()

    -- Upon Mijin Gakure, Gola will become active.
    if skillID == xi.mobSkill.MIJIN_GAKURE_1 then
        local mobID         = mob:getID()
        local golaMob       = GetMobByID(mobID + 1)
        local currentTarget = mob:getTarget()       -- The target passed in will be itself.

        -- The next tree becomes active and attacks the target.
        if golaMob and currentTarget then
            golaMob:updateEnmity(currentTarget)
        end
    end
end

return entity
