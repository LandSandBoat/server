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
entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.DOKUMORI_NI,
        xi.magic.spell.DOTON_NI,
        xi.magic.spell.HOJO_NI,
        xi.magic.spell.HUTON_NI,
        xi.magic.spell.HYOTON_NI,
        xi.magic.spell.JUBAKU_NI,
        xi.magic.spell.KATON_NI,
        xi.magic.spell.KURAYAMI_NI,
        xi.magic.spell.RAITON_NI,
        xi.magic.spell.SUITON_NI,
    }

    return spellList[math.random(1, #spellList)]
end

-----------------------------------
-- Only uses one TP move.
-----------------------------------
entity.onMobMobskillChoose = function(mob, target)
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
