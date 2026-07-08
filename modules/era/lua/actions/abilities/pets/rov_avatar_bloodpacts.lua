-----------------------------------
-- Date : 2016 November 10th Patch
-- Notes: https://wiki.ffo.jp/html/35795.html
--        Multihit skills' fTPs were lowered but the first hit fTP carried over into subsequent hits.
--        In 75 era, the subsequent hits had a 1.0 multiplier.
--        Old fTPs might be lost to time unless there new data is uncovered through online documentation or client data.
-----------------------------------
require('modules/module_utils')
-----------------------------------

local moduleName = 'rov_avatar_bloodpacts'

if xi.module.isContentEnabled('ROV') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

-----------------------------------
-- Axe Kick
-----------------------------------
m:addOverride('xi.actions.abilities.pets.axe_kick.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local params = {}

    params.baseDamage        = pet:getWeaponDmg()
    params.numHits           = 1
    params.fTP               = { 2.00, 2.00, 2.00 }
    params.fTPSubsequentHits = { 1.00, 1.00, 1.00 }
    params.str_wSC           = 0.30
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.BLUNT
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.attackMultiplier  = { 2.0, 2.0, 2.0 }
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobPhysicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)
    end

    return info.damage
end)

-----------------------------------
-- Barracuda Dive
-----------------------------------
m:addOverride('xi.actions.abilities.pets.barracuda_dive.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local params = {}

    params.baseDamage        = pet:getWeaponDmg()
    params.numHits           = 1
    params.fTP               = { 2.00, 2.00, 2.00 }
    params.fTPSubsequentHits = { 1.00, 1.00, 1.00 }
    params.str_wSC           = 0.30
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.SLASHING
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.attackMultiplier  = { 2.0, 2.0, 2.0 }
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobPhysicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)
    end

    return info.damage
end)

-----------------------------------
-- Blindside
-----------------------------------
m:addOverride('xi.actions.abilities.pets.blindside.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local params = {}

    params.baseDamage        = pet:getWeaponDmg()
    params.numHits           = 1
    params.fTP               = { 2.00, 2.00, 2.00 }
    params.fTPSubsequentHits = { 1.00, 1.00, 1.00 }
    -- params.str_wSC           = 0.20 -- TODO: Capture wSCs
    -- params.mnd_wSC           = 0.20
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.BLUNT
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobPhysicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)
    end

    return info.damage
end)

-----------------------------------
-- Burning Strike
-----------------------------------
m:addOverride('xi.actions.abilities.pets.burning_strike.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local params = {}

    params.baseDamage         = pet:getWeaponDmg()
    params.numHits            = 1
    params.fTP                = { 2.75, 2.75, 2.75 }
    params.fTPSubsequentHits  = { 2.75, 2.75, 2.75 }
    params.str_wSC            = 0.20
    params.int_wSC            = 0.20
    params.attackType         = xi.attackType.PHYSICAL
    params.damageType         = xi.damageType.BLUNT
    params.hybridSkill        = true
    params.hybridSkillElement = xi.element.FIRE
    params.hybridAttackType   = xi.attackType.MAGICAL
    params.hybridDamageType   = xi.damageType.FIRE
    params.shadowBehavior     = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobPhysicalMove(pet, target, petskill, action, params)

    local totalDamage = 0

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        if info.damage > 0 then
            target:takeDamage(info.damage, pet, info.attackType, info.damageType)
            totalDamage = totalDamage + info.damage
        end

        if info.hybridDamage > 0 and target:getHP() > 0 then
            target:takeDamage(info.hybridDamage, pet, info.hybridAttackType, info.hybridDamageType)
            totalDamage = totalDamage + info.hybridDamage
        end
    end

    return totalDamage
end)

-----------------------------------
-- Camisado
-----------------------------------
m:addOverride('xi.actions.abilities.pets.camisado.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local params = {}

    params.baseDamage        = pet:getWeaponDmg()
    params.numHits           = 1
    params.fTP               = { 2.0, 2.0, 2.0 }
    params.fTPSubsequentHits = { 2.0, 2.0, 2.0 }
    params.str_wSC           = 0.20
    params.mnd_wSC           = 0.20
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.BLUNT
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.attackMultiplier  = { 2.0, 2.0, 2.0 }
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobPhysicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)

        -- TODO: Knockback may not yet be hooked up to abilities.
        -- action:knockback(target:getID(), xi.action.knockback.LEVEL3)

        -- TODO: Some equipment that reduces movement speed can reduce knockback distance. (Example: Plumb Boots)
        -- https://discord.com/channels/392903136336936960/883227978002206751/1280243231635804262
        -- https://discord.com/channels/443544205206355968/443893540922064896/1376405495845355661
    end

    return info.damage
end)

-----------------------------------
-- Chaotic Strike
-----------------------------------
m:addOverride('xi.actions.abilities.pets.chaotic_strike.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

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
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

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
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

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
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

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
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

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
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

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
-- Flaming Crush
-----------------------------------
m:addOverride('xi.actions.abilities.pets.flaming_crush.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local params = {}

    params.baseDamage         = pet:getWeaponDmg()
    params.numHits            = 2
    params.fTP                = { 6.00, 6.00, 6.00 }
    params.fTPSubsequentHits  = { 1.00, 1.00, 1.00 }
    params.str_wSC            = 0.20
    params.int_wSC            = 0.20
    params.attackType         = xi.attackType.PHYSICAL
    params.damageType         = xi.damageType.BLUNT
    params.hybridSkill        = true
    params.hybridSkillElement = xi.element.FIRE
    params.hybridAttackType   = xi.attackType.MAGICAL
    params.hybridDamageType   = xi.damageType.FIRE
    params.shadowBehavior     = xi.mobskills.shadowBehavior.NUMSHADOWS_2
    params.primaryMessage     = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobPhysicalMove(pet, target, petskill, action, params)

    local totalDamage = 0

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        if info.damage > 0 then
            target:takeDamage(info.damage, pet, info.attackType, info.damageType)
            totalDamage = totalDamage + info.damage
        end

        if info.hybridDamage > 0 and target:getHP() > 0 then
            target:takeDamage(info.hybridDamage, pet, info.hybridAttackType, info.hybridDamageType)
            totalDamage = totalDamage + info.hybridDamage
        end
    end

    return totalDamage
end)

-----------------------------------
-- Megalith Throw
-----------------------------------
m:addOverride('xi.actions.abilities.pets.megalith_throw.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local params = {}

    params.baseDamage        = pet:getRangedDmg()
    params.numHits           = 1
    params.fTP               = { 2.375, 2.375, 2.375 }
    params.fTPSubsequentHits = { 1.000, 1.000, 1.000 }
    params.str_wSC           = 0.20
    params.agi_wSC           = 0.20
    params.skipParry         = true
    params.skipGuard         = true
    params.skipBlock         = true
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.SLASHING
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobRangedMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)

        local effectTable =
        {
            [1] = { effectId = xi.effect.SLOW, power = 3000, duration = 120, tier = 8, origin = pet }, -- TODO: Capture Slow tier
        }

        xi.combat.action.executeMobskillStatusEffect(pet, target, petskill, effectTable, { messageBypass = true })
    end

    return info.damage
end)

-----------------------------------
-- Moonlit Charge
-----------------------------------
m:addOverride('xi.actions.abilities.pets.moonlit_charge.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local params = {}

    params.baseDamage        = pet:getWeaponDmg()
    params.numHits           = 1
    params.fTP               = { 1.00, 1.00, 1.00 }
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
            [1] = { effectId = xi.effect.BLINDNESS, power = 25, duration = 60, origin = pet },
        }

        xi.combat.action.executeMobskillStatusEffect(pet, target, petskill, effectTable, { messageBypass = true })
    end

    return info.damage
end)

-----------------------------------
-- Mountain Buster
-----------------------------------
m:addOverride('xi.actions.abilities.pets.mountain_buster.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

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
    end

    return info.damage
end)

-----------------------------------
-- Poison Nails
-----------------------------------
m:addOverride('xi.actions.abilities.pets.poison_nails.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

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
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobPhysicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)

        local effectTable =
        {
            [1] = { effectId = xi.effect.POISON, power = 1, tick = 3, duration = 90, tier = 1, origin = pet },
        }

        xi.combat.action.executeMobskillStatusEffect(pet, target, petskill, effectTable, { messageBypass = true })
    end

    return info.damage
end)

-----------------------------------
-- Predator Claws
-----------------------------------
m:addOverride('xi.actions.abilities.pets.predator_claws.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local params = {}

    params.baseDamage        = pet:getWeaponDmg()
    params.numHits           = 3
    params.fTP               = { 10.00, 10.00, 10.00 }
    params.fTPSubsequentHits = { 1.00, 1.00, 1.00 }
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
-- Punch
-----------------------------------
m:addOverride('xi.actions.abilities.pets.punch.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local params = {}

    params.baseDamage        = pet:getWeaponDmg()
    params.numHits           = 1
    params.fTP               = { 2.00, 2.00, 2.00 }
    params.fTPSubsequentHits = { 1.00, 1.00, 1.00 }
    params.str_wSC           = 0.30
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.BLUNT
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.attackMultiplier  = { 2.0, 2.0, 2.0 }
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
-- Regal Scratch
-----------------------------------
m:addOverride('xi.actions.abilities.pets.regal_scratch.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local params = {}

    -- https://wiki.ffo.jp/html/26384.html
    -- JP Wiki states that this skill was excluded from carrying first hit fTP to subsequent hits.
    -- (See Patch note history for November 10th, 2016 in above link.)

    params.baseDamage        = pet:getWeaponDmg()
    params.numHits           = 3
    params.fTP               = { 3.00, 3.00, 3.00 } -- TODO: Capture fTPs
    params.fTPSubsequentHits = { 1.00, 1.00, 1.00 }
    -- params.dex_wSC           = 0.30
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
-- Rock Buster
-----------------------------------
m:addOverride('xi.actions.abilities.pets.rock_buster.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

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
-- Rock Throw
-----------------------------------
m:addOverride('xi.actions.abilities.pets.rock_throw.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local params = {}

    params.baseDamage        = pet:getRangedDmg()
    params.numHits           = 1
    params.fTP               = { 1.00, 1.00, 1.00 }
    params.fTPSubsequentHits = { 1.00, 1.00, 1.00 }
    params.str_wSC           = 0.20
    params.agi_wSC           = 0.20
    params.skipParry         = true
    params.skipGuard         = true
    params.skipBlock         = true
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.SLASHING
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobRangedMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)

        local effectTable =
        {
            [1] = { effectId = xi.effect.SLOW, power = 3000, duration = 120, tier = 8, origin = pet }, -- TODO: Capture Slow tier
        }

        xi.combat.action.executeMobskillStatusEffect(pet, target, petskill, effectTable, { messageBypass = true })
    end

    return info.damage
end)

-----------------------------------
-- Rush
-----------------------------------
m:addOverride('xi.actions.abilities.pets.rush.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

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
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

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
-- Spinning Dive
-----------------------------------
m:addOverride('xi.actions.abilities.pets.spinning_dive.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local params = {}

    params.baseDamage        = pet:getWeaponDmg()
    params.numHits           = 1
    params.fTP               = { 7.01171, 7.01171, 7.01171 }
    params.fTPSubsequentHits = { 1.00000, 1.00000, 1.00000 }
    params.str_wSC           = 0.30
    params.attackType        = xi.attackType.PHYSICAL
    params.damageType        = xi.damageType.SLASHING
    params.shadowBehavior    = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.attackMultiplier  = { 2.0, 2.0, 2.0 }
    params.primaryMessage    = xi.msg.basic.USES_JA_TAKE_DAMAGE

    local info = xi.mobskills.mobPhysicalMove(pet, target, petskill, action, params)

    if xi.mobskills.processDamage(pet, target, petskill, action, info) then
        target:takeDamage(info.damage, pet, info.attackType, info.damageType)
    end

    return info.damage
end)

-----------------------------------
-- Tail Whip
-----------------------------------
m:addOverride('xi.actions.abilities.pets.tail_whip.onPetAbility', function(target, pet, petskill, summoner, action)
    xi.job_utils.summoner.onUseBloodPact(target, petskill, summoner, action)

    local params = {}

    params.baseDamage        = pet:getWeaponDmg()
    params.numHits           = 1
    params.fTP               = { 3.00, 3.00, 3.00 }
    params.fTPSubsequentHits = { 1.00, 1.00, 1.00 }
    params.str_wSC           = 0.30
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
            [1] = { effectId = xi.effect.WEIGHT, power = 50, duration = 120, tier = 1, origin = pet }, -- TODO: Capture power/duration/tier
        }

        xi.combat.action.executeMobskillStatusEffect(pet, target, petskill, effectTable, { messageBypass = true })
    end

    return info.damage
end)

-----------------------------------
-- Volt Strike
-----------------------------------
-- TODO: Volt Strike is not currently coded at time of this comment but should be set to 1.0 for fTPSubsequentHits. Loses Crit Scaling.

return m
