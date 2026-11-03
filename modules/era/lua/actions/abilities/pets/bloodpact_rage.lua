-----------------------------------
-- Module: Blood Pact: Rage era adjustments
-- Date : 2016 November 10th Patch
-- Notes: https://wiki.ffo.jp/html/35795.html
--        Restores how physical Blood Pact: Rage skills behaved before the update:
--        - Subsequent hits: The update lowered multihit fTPs but carried the first hit's fTP over into later hits.
--          Before it, every hit after the first had an fTP of 1.0.
--          (Chaotic Strike, Double Punch, Double Slap, Eclipse Bite, Predator Claws, Rush)
--        - TP damage scaling: Damage did not vary with TP. These skills use their 1000 TP fTP at any TP.
--          (Crescent Fang, Eclipse Bite, Mountain Buster, Rock Buster)
--        - Critical hits: These skills could crit, but their critical hit rate did not vary with TP.
--          (Chaotic Strike, Claw, Predator Claws, Shock Strike)
--        Old fTPs might be lost to time unless new data is uncovered through online documentation or client data.
--        Only skills whose current script differs from the above are overridden. Flaming Crush and Regal Scratch
--        already use 1.0 for subsequent hits, and single hit skills never use fTPSubsequentHits.
--        Each override is a copy of the current script with only the changes above, so keep them in sync with it.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_bloodpact_rage', xi.pre(xi.expansion.ROV))

-----------------------------------
-- Chaotic Strike
-----------------------------------
m:addOverride('xi.actions.abilities.pets.chaotic_strike.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, pet, petskill, summoner, action)

    local params = {}

    params.baseDamage        = pet:getWeaponDmg()
    params.numHits           = 3
    params.fTP               = { 10.00, 10.00, 10.00 }
    params.fTPSubsequentHits = { 1.00, 1.00, 1.00 }
    params.str_wSC           = 0.20
    params.int_wSC           = 0.20
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.BLUNT
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_3
    params.canCrit           = true
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobPhysicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)

        local effectTable =
        {
            [1] = { effectId = xi.effect.STUN, power = 1, duration = 12, origin = pet },
        }

        xi.combat.action.executeMobskillStatusEffect(pet, target, petskill, effectTable, { messageBypass = true })
    end

    return info.damage
end)

-----------------------------------
-- Claw
-----------------------------------
m:addOverride('xi.actions.abilities.pets.claw.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, pet, petskill, summoner, action)

    local params = {}

    params.baseDamage        = pet:getWeaponDmg()
    params.numHits           = 1
    params.fTP               = { 2.00, 2.00, 2.00 }
    params.fTPSubsequentHits = { 1.00, 1.00, 1.00 }
    params.dex_wSC           = 0.30
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.PIERCING
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.attackMultiplier  = { 2.0, 2.0, 2.0 }
    params.canCrit           = true
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobPhysicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)
    end

    return info.damage
end)

-----------------------------------
-- Crag Throw
-----------------------------------
-- TODO: Not currently coded at time of this comment. Does not gain an accuracy bonus based on fTP.

-----------------------------------
-- Crescent Fang
-----------------------------------
m:addOverride('xi.actions.abilities.pets.crescent_fang.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, pet, petskill, summoner, action)

    local params = {}

    params.baseDamage        = pet:getWeaponDmg()
    params.numHits           = 1
    params.fTP               = { 1.50, 1.50, 1.50 }
    params.fTPSubsequentHits = { 1.00, 1.00, 1.00 }
    params.str_wSC           = 0.30
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.PIERCING
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.attackMultiplier  = { 2.0, 2.0, 2.0 }
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobPhysicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)

        local effectTable =
        {
            [1] = { effectId = xi.effect.PARALYSIS, power = 22, duration = 60, origin = pet }, -- TODO: Capture power
        }

        xi.combat.action.executeMobskillStatusEffect(pet, target, petskill, effectTable, { messageBypass = true })
    end

    return info.damage
end)

-----------------------------------
-- Double Punch
-----------------------------------
m:addOverride('xi.actions.abilities.pets.double_punch.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, pet, petskill, summoner, action)

    local params = {}

    params.baseDamage        = pet:getWeaponDmg()
    params.numHits           = 2
    params.fTP               = { 5.00, 5.00, 5.00 }
    params.fTPSubsequentHits = { 1.00, 1.00, 1.00 }
    params.str_wSC           = 0.30
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.BLUNT
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_2
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobPhysicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)
    end

    return info.damage
end)

-----------------------------------
-- Double Slap
-----------------------------------
m:addOverride('xi.actions.abilities.pets.double_slap.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, pet, petskill, summoner, action)

    local params = {}

    params.baseDamage        = pet:getWeaponDmg()
    params.numHits           = 2
    params.fTP               = { 6.328125, 6.328125, 6.328125 }
    params.fTPSubsequentHits = { 1.000000, 1.000000, 1.000000 }
    params.str_wSC           = 0.30
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.BLUNT
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_2
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobPhysicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)
    end

    return info.damage
end)

-----------------------------------
-- Eclipse Bite
-----------------------------------
m:addOverride('xi.actions.abilities.pets.eclipse_bite.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, pet, petskill, summoner, action)

    local params = {}

    params.baseDamage        = pet:getWeaponDmg()
    params.numHits           = 3
    params.fTP               = { 3.269531, 3.269531, 3.269531 }
    params.fTPSubsequentHits = { 1.000000, 1.000000, 1.000000 }
    params.dex_wSC           = 0.30
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.SLASHING
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_3
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobPhysicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)
    end

    return info.damage
end)

-----------------------------------
-- Mountain Buster
-----------------------------------
m:addOverride('xi.actions.abilities.pets.mountain_buster.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, pet, petskill, summoner, action)

    local params = {}

    params.baseDamage        = pet:getWeaponDmg()
    params.numHits           = 1
    params.fTP               = { 7.25, 7.25, 7.25 }
    params.fTPSubsequentHits = { 1.00, 1.00, 1.00 }
    params.vit_wSC           = 0.30
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.BLUNT
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.attackMultiplier  = { 2.0, 2.0, 2.0 }
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobRangedMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)

        local effectTable =
        {
            [1] = { effectId = xi.effect.BIND, power = 1, duration = math.randomInt(13, 60) }, -- TODO: Get additional captures.
        }

        xi.combat.action.executeMobskillStatusEffect(pet, target, petskill, effectTable, { messageBypass = true })
    end

    return info.damage
end)

-----------------------------------
-- Predator Claws
-----------------------------------
m:addOverride('xi.actions.abilities.pets.predator_claws.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, pet, petskill, summoner, action)

    local params = {}

    params.baseDamage        = pet:getWeaponDmg()
    params.numHits           = 3
    params.fTP               = { 10.00, 10.00, 10.00 }
    params.fTPSubsequentHits = { 1.00, 1.00, 1.00 }
    params.dex_wSC           = 0.30
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.SLASHING
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_3
    params.canCrit           = true
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobPhysicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)
    end

    return info.damage
end)

-----------------------------------
-- Regal Gash
-----------------------------------
-- TODO: Not coded at time of this comment. Loses accuracy ftp scaling.

-----------------------------------
-- Rock Buster
-----------------------------------
m:addOverride('xi.actions.abilities.pets.rock_buster.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, pet, petskill, summoner, action)

    local params = {}

    params.baseDamage        = pet:getWeaponDmg()
    params.numHits           = 1
    params.fTP               = { 2.25, 2.25, 2.25 }
    params.fTPSubsequentHits = { 1.00, 1.00, 1.00 }
    params.vit_wSC           = 0.30
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.BLUNT
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.attackMultiplier  = { 2.0, 2.0, 2.0 }
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobPhysicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)

        local effectTable =
        {
            [1] = { effectId = xi.effect.BIND, power = 1, duration = 120, origin = pet }, -- TODO: Capture duration
        }

        xi.combat.action.executeMobskillStatusEffect(pet, target, petskill, effectTable, { messageBypass = true })
    end

    return info.damage
end)

-----------------------------------
-- Rush
-----------------------------------
m:addOverride('xi.actions.abilities.pets.rush.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, pet, petskill, summoner, action)

    local params = {}

    params.baseDamage        = pet:getWeaponDmg()
    params.numHits           = 5
    params.fTP               = { 3.50, 3.50, 3.50 }
    params.fTPSubsequentHits = { 1.00, 1.00, 1.00 }
    params.str_wSC           = 0.30
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.BLUNT
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_5
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobPhysicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)
    end

    return info.damage
end)

-----------------------------------
-- Shock Strike
-----------------------------------
m:addOverride('xi.actions.abilities.pets.shock_strike.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, pet, petskill, summoner, action)

    local params = {}

    params.baseDamage        = pet:getWeaponDmg()
    params.numHits           = 1
    params.fTP               = { 2.00, 2.00, 2.00 }
    params.fTPSubsequentHits = { 1.00, 1.00, 1.00 }
    params.str_wSC           = 0.20
    params.int_wSC           = 0.20
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.BLUNT
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.attackMultiplier  = { 2.0, 2.0, 2.0 }
    params.canCrit           = true
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobPhysicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)

        local effectTable =
        {
            [1] = { effectId = xi.effect.STUN, power = 1, duration = 12, origin = pet },
        }

        xi.combat.action.executeMobskillStatusEffect(pet, target, petskill, effectTable, { messageBypass = true })
    end

    return info.damage
end)

-----------------------------------
-- Volt Strike
-----------------------------------
-- TODO: Volt Strike is not currently coded at time of this comment but should be set to 1.0 for fTPSubsequentHits. Can Crit but loses TP Crit Scaling.
