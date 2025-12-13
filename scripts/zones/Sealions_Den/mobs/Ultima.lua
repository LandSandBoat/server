-----------------------------------
-- Area: Sealions Den
--   NM: Ultima
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.REGAIN, 150)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 125)
    mob:setMod(xi.mod.ATTP, 30)
    mob:setLocalVar('phase', 1) -- Set to 1 for readability
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('nextChemBomb', GetSystemTime() + 60)
    mob:useMobAbility(xi.mobSkill.PARTICLE_SHIELD)
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    local hpp         = mob:getHPP()
    local phase       = mob:getLocalVar('phase')
    local currentTime = GetSystemTime()

    switch (phase): caseof
    {
        -- Phase 1: Normal TP use with scripted chemical bomb
        -- Uses Chemical Bomb every 60-90 seconds
        [1] = function()
            local nextChemBomb = mob:getLocalVar('nextChemBomb')
            if currentTime >= nextChemBomb then
                mob:setLocalVar('nextChemBomb', currentTime + math.random(60, 90))
                mob:useMobAbility(xi.mobSkill.CHEMICAL_BOMB)
            end

            -- 70% HPP: Entering Nuclear Waste phase
            if hpp < 70 then
                mob:setLocalVar('phase', 2)
                mob:setMobAbilityEnabled(false)
                mob:useMobAbility(xi.mobSkill.NUCLEAR_WASTE)
                mob:setLocalVar('nextNuke', currentTime + math.random(25, 35))
                return
            end
        end,

        -- Phase 2: Scripted timer of Nuclear Waste -> Random Elemental Conal
        [2] = function()
            local nextNuke = mob:getLocalVar('nextNuke')
            if currentTime >= nextNuke then
                mob:setLocalVar('nextNuke', currentTime + math.random(25, 35))
                mob:useMobAbility(xi.mobSkill.NUCLEAR_WASTE)
            end

            -- 40% HPP: Entering Equalizer phase
            if hpp < 40 then
                mob:setLocalVar('phase', 3)
                mob:setMobAbilityEnabled(true)
                mob:useMobAbility(xi.mobSkill.EQUALIZER)
                return
            end
        end,

        -- Phase 3: Normal TP use with Equalizer instead of Wire Cutter
        [3] = function()
            -- 15% HPP: Entering Antimatter phase
            if hpp < 15 then
                mob:setLocalVar('phase', 4)
                mob:setMobAbilityEnabled(false)
                mob:setLocalVar('abilityOrder', 1)
                mob:useMobAbility(xi.mobSkill.PARTICLE_SHIELD)
            end
        end,

        -- Phase 4: Scripted Particle Shield -> Antimatter -> Antimatter chain
        [4] = function()
            local nextAntimatter = mob:getLocalVar('nextAntimatter')
            local abilityOrder   = mob:getLocalVar('abilityOrder')

            if abilityOrder == 0 and currentTime >= nextAntimatter then
                mob:setLocalVar('abilityOrder', 1)
                mob:useMobAbility(xi.mobSkill.PARTICLE_SHIELD)
            end
        end,
    }
end

entity.onMobMobskillChoose = function(mob, target)
    local phase    = mob:getLocalVar('phase')
    local tpSkills = {}

    switch (phase): caseof
    {
        [1] = function()
            tpSkills =
            {
                { xi.mobSkill.WIRE_CUTTER,     50 },
                { xi.mobSkill.CHEMICAL_BOMB,   25 },
                { xi.mobSkill.PARTICLE_SHIELD, 25 },
            }
        end,

        -- Phase 2: Mob abilities disabled; Nuclear Waste chain handled in onMobFight.
        [2] = function()
            return 0
        end,

        [3] = function()
            tpSkills =
            {
                { xi.mobSkill.EQUALIZER,       60 },
                { xi.mobSkill.CHEMICAL_BOMB,   20 },
                { xi.mobSkill.PARTICLE_SHIELD, 20 },
            }
        end,

        -- Phase 4: Mob abilities disabled; Antimatter chain handled in onMobFight.
        [4] = function()
            return 0
        end,
    }

    local roll      = math.random(1, 100)
    local weightSum = 0
    for i = 1, #tpSkills do
        weightSum = weightSum + tpSkills[i][2]
        if roll <= weightSum then
            return tpSkills[i][1]
        end
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local skillID = skill:getID()
    local phase   = mob:getLocalVar('phase')

    -- Nuclear Waste phase: Follow up with a random elemental conal
    if phase == 2 and skillID == xi.mobSkill.NUCLEAR_WASTE then
        local eleConal = math.random(xi.mobSkill.FLAME_THROWER, xi.mobSkill.HYDRO_CANON)
        mob:useMobAbility(eleConal)
    end

    -- Antimatter phase: Scripted Particle Shield -> Antimatter -> Antimatter chain
    if phase == 4 then
        local abilityOrder = mob:getLocalVar('abilityOrder')

        if skillID == xi.mobSkill.PARTICLE_SHIELD and abilityOrder == 1 then
            mob:setLocalVar('abilityOrder', 2)
            mob:useMobAbility(xi.mobSkill.ANTIMATTER)
        elseif skillID == xi.mobSkill.ANTIMATTER then
            -- First Antimatter finished, force second Antimatter
            if abilityOrder == 2 then
                mob:setLocalVar('abilityOrder', 3)
                mob:useMobAbility(xi.mobSkill.ANTIMATTER)

            -- Second Antimatter finished, set timer for next rotation
            elseif abilityOrder == 3 then
                mob:setLocalVar('abilityOrder', 0)
                mob:setLocalVar('nextAntimatter', GetSystemTime() + math.random(15, 20))
            end
        end
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PARALYZE, { duration = 60 })
end

return entity
