-----------------------------------
-- Area: Balga's Dais
--  Mob: Gilagoge Tlugvi (WHM) "Spring Tree"
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
    mob:setLocalVar('benedictionUsed', 0)
end

-----------------------------------
-- Additional effect: Dispel
-----------------------------------
entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.DISPEL, { chance = 15 })
end

-----------------------------------
-- Only uses one TP move.
-----------------------------------
entity.onMobMobskillChoose = function(mob, target)
    return xi.mobSkill.ENTANGLE
end

-----------------------------------
-- Using 2-Hour causes the next tree to engage the player.
-----------------------------------
entity.onMobWeaponSkill = function(target, mob, skill)
    local skillID = skill:getID()

    -- Upon Benediction, Goga will become active.
    -- Benediction comes through for every mob hit, so need add a block.
    if skillID == xi.mobSkill.BENEDICTION_1 and mob:getLocalVar('benedictionUsed') ~= 1 then
        local mobID         = mob:getID()
        local gogaMob       = GetMobByID(mobID + 1)
        local currentTarget = mob:getTarget()       -- The target passed in will be itself.

        -- The next tree becomes active and attacks the target.
        if gogaMob and currentTarget then
            gogaMob:updateEnmity(currentTarget)
        end

        mob:setLocalVar('benedictionUsed', 1)
    end
end

return entity
