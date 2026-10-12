-----------------------------------
-- Module: Era jugpet mobskill adjustments
-- https://wiki.ffo.jp/html/30566.html
-- Notes: Reverts retail jugpet skills.
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('era_jugpet_mobskills')

-----------------------------------
-- Foot Kick
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.foot_kick_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage      = mob:getWeaponDmg()
        params.numHits         = 1
        params.fTP             = { 1.0, 1.0, 1.0 }
        params.attackType      = xi.attackType.PHYSICAL
        params.damageType      = xi.damageType.SLASHING
        params.shadowBehavior  = xi.mobskills.shadowBehavior.NUMSHADOWS_1
        params.canCrit         = true
        params.criticalChance  = { 1.0, 1.0, 1.0 }

        if mob:getMainLvl() >= 50 then
            params.fTP = { 2, 2, 2 }
        end

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Dust Cloud
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.dust_cloud_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getMainLvl() + 2
        params.fTP            = { 2.0, 2.0, 2.0 }
        params.element        = xi.element.EARTH
        params.attackType     = xi.attackType.MAGICAL
        params.damageType     = xi.damageType.EARTH
        params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

        local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)

            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 30, 0, 120)
        end

        return info.damage
    end,
})

-----------------------------------
-- Whirl Claws
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.whirl_claws_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 2.0, 2.0, 2.0 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.SLASHING
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Head Butt
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.head_butt_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 2.0, 2.0, 2.0 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.BLUNT
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Dream Flower
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.dream_flower_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, math.randomInt(15, 60)))
    end,
})

-----------------------------------
-- Wild Oats
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.wild_oats_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 1.0, 1.0, 1.0 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.PIERCING
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)

            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.VIT_DOWN, 10, 9, 120)
        end

        return info.damage
    end,
})

-----------------------------------
-- Leaf Dagger
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.leaf_dagger_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getRangedDmg()
        params.numHits        = 1
        params.fTP            = { 2.0, 2.0, 2.0 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.PIERCING
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1
        params.skipParry      = true
        params.skipGuard      = true
        params.skipBlock      = true

        local info = xi.mobskills.mobRangedMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)

            local power   = math.max(1, mob:getMainLvl() / 10)
            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, power, 3, 90)
        end

        return info.damage
    end,
})

-----------------------------------
-- Scream
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.scream_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MND_DOWN, 10, 3, 180))

        return xi.effect.MND_DOWN
    end,
})

-----------------------------------
-- Roar
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.roar_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 50, 0, 120))

        return xi.effect.PARALYSIS
    end,
})

-----------------------------------
-- Razor Fang
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.razor_fang_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 3.0, 3.0, 3.0 } -- TODO: Capture fTPs
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.PIERCING
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Claw Cyclone
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.claw_cyclone_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 2.0, 2.0, 2.0 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.SLASHING
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3 -- TODO: Capture shadowBehavior

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Tail Blow
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.tail_blow_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 1.5, 1.5, 1.5 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.SLASHING
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)

            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 4) -- TODO: Capture stun duration
        end

        return info.damage
    end,
})

-----------------------------------
-- Fireball
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.fireball_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getMainLvl() + 2
        params.fTP            = { 2.5, 2.5, 2.5 }
        params.element        = xi.element.FIRE
        params.attackType     = xi.attackType.MAGICAL
        params.damageType     = xi.damageType.FIRE
        params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

        local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Blockhead
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.blockhead_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 2.0, 2.0, 2.0 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.BLUNT
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Brain Crush
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.brain_crush_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 1.0, 1.0, 1.0 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.BLUNT
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)

            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 30)
        end

        return info.damage
    end,
})

-----------------------------------
-- Infrasonics
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.infrasonics_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.EVASION_DOWN, 25, 0, 180, 1))

        return xi.effect.EVASION_DOWN
    end,
})

-----------------------------------
-- Secretion
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.secretion_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        skill:setMsg(xi.mobskills.mobBuffMove(target, xi.effect.EVASION_BOOST, 25, 0, 60))

        return xi.effect.EVASION_BOOST
    end,
})

-----------------------------------
-- Lamb Chop
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.lamb_chop_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 2.0, 3.0, 4.0 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.BLUNT
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Rage
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.rage_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        skill:setMsg(xi.mobskills.mobBuffMove(target, xi.effect.BERSERK, 45, 0, 120, 0, 25))

        return xi.effect.BERSERK
    end,
})

-----------------------------------
-- Sheep Charge
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.sheep_charge_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 1.0, 2.0, 3.0 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.BLUNT
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1
        -- This may have missing attack modifiers

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
--Sheep Song
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.sheep_song_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, 45))

        return xi.effect.SLEEP_I
    end,
})

-----------------------------------
-- Bubble Shower
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.bubble_shower_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.percentMultipier = 0.0625
        params.damageCap        = 200
        params.bonusDamage      = 0
        params.mAccuracyBonus   = { 0, 0, 0 }
        params.resistStat       = xi.mod.INT
        params.element          = xi.element.WATER
        params.attackType       = xi.attackType.BREATH
        params.damageType       = xi.damageType.WATER
        params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

        local info = xi.mobskills.mobBreathMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)

            local power    = 10
            local duration = 180

            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STR_DOWN, power, 9, duration)
        end

        return info.damage
    end,
})

-----------------------------------
-- Bubble Curtain
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.bubble_curtain_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        skill:setMsg(xi.mobskills.mobBuffMove(target, xi.effect.SHELL, 5000, 0, 180))

        return xi.effect.SHELL
    end,
})

-----------------------------------
-- Big Scissors
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.big_scissors_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 1.0, 1.0, 1.0 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.SLASHING
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1
        params.canCrit        = true
        params.criticalChance = { 1.00, 1.00, 1.00 }

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Scissor Guard
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.scissor_guard_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        skill:setMsg(xi.mobskills.mobBuffMove(target, xi.effect.DEFENSE_BOOST, 100, 0, 60))

        return xi.effect.DEFENSE_BOOST
    end,
})

-----------------------------------
-- Metallic Body
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.metallic_body_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        skill:setMsg(xi.mobskills.mobBuffMove(target, xi.effect.STONESKIN, 25, 0, 300))

        return xi.effect.STONESKIN
    end,
})

-----------------------------------
-- Needle Shot
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.needleshot_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getRangedDmg()
        params.numHits        = 1
        params.fTP            = { 2.0, 2.0, 2.0 }
        params.attackType     = xi.attackType.RANGED
        params.damageType     = xi.damageType.PIERCING
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1
        params.skipParry      = true
        params.skipGuard      = true
        params.skipBlock      = true

        local info = xi.mobskills.mobRangedMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Random Needles (1000 Needles in era)
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.random_needles_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage         = 1000 / skill:getTotalTargets()
        params.numHits            = 1
        params.fTP                = { 1.0, 1.0, 1.0 }
        params.attackType         = xi.attackType.PHYSICAL
        params.damageType         = xi.damageType.PIERCING
        params.shadowBehavior     = xi.mobskills.shadowBehavior.WIPE_SHADOWS
        params.guaranteedFirstHit = true
        params.skipPDIF           = true
        params.skipFSTR           = true
        params.skipParry          = true
        params.skipGuard          = true
        params.skipBlock          = true

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Frog Kick
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.frogkick_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 1.5, 1.5, 1.5 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.PIERCING
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1
        params.canCrit        = true
        params.criticalChance = { 0.10, 0.20, 0.25 } -- TODO: Capture crit rate

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Spore
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.spore_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 15, 0, 180))

        return xi.effect.PARALYSIS
    end,
})

-----------------------------------
-- Queasyshroom
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.queasyshroom_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 1.5, 1.5, 1.5 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.PIERCING
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1
        params.canCrit        = true
        params.criticalChance = { 0.10, 0.20, 0.25 } -- TODO: Capture crit rate

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)

            local power = mob:getMainLvl() / 10 + 1
            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, power, 3, 60)
        end

        return info.damage
    end,
})

-----------------------------------
-- Numbshroom
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.numbshroom_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 1.5, 1.5, 1.5 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.PIERCING
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1
        params.canCrit        = true
        params.criticalChance = { 0.10, 0.20, 0.25 } -- TODO: Capture crit rate

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)

            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 25, 0, 180)
        end

        return info.damage
    end,
})

-----------------------------------
-- Shakeshroom
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.shakeshroom_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 1.5, 1.5, 1.5 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.PIERCING
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1
        params.canCrit        = true
        params.criticalChance = { 0.10, 0.20, 0.25 } -- TODO: Capture crit rate

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)

            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DISEASE, 1, 0, 720)
        end

        return info.damage
    end,
})

-----------------------------------
-- Silence Gas
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.silence_gas_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.percentMultipier = 0.25
        params.damageCap        = 800 -- TODO: Capture cap
        params.bonusDamage      = 0
        params.mAccuracyBonus   = { 0, 0, 0 }
        params.resistStat       = xi.mod.INT
        params.element          = xi.element.DARK
        params.attackType       = xi.attackType.BREATH
        params.damageType       = xi.damageType.DARK
        params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

        local info = xi.mobskills.mobBreathMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)

            local duration = math.randomInt(15, 60)
            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, duration)
        end

        return info.damage
    end,
})

-----------------------------------
-- Dark Spore
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.dark_spore_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.percentMultipier = 0.25
        params.damageCap        = 600 -- TODO: Capture damage cap.
        params.bonusDamage      = 0
        params.mAccuracyBonus   = { 0, 0, 0 }
        params.resistStat       = xi.mod.INT
        params.element          = xi.element.DARK
        params.attackType       = xi.attackType.BREATH
        params.damageType       = xi.damageType.DARK
        params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

        local info = xi.mobskills.mobBreathMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)

            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 30, 0, 90)
        end

        return info.damage
    end,
})

-----------------------------------
-- Power Attack (Beetle)
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.power_attack_beetle_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage       = mob:getWeaponDmg()
        params.numHits          = 1
        params.fTP              = { 1.0, 1.0, 1.0 }
        params.attackType       = xi.attackType.PHYSICAL
        params.damageType       = xi.damageType.HAND_TO_HAND
        params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_1
        params.attackMultiplier = { 2.0, 2.0, 2.0 }

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Hi-Freq Field
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.hi-freq_field_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.EVASION_DOWN, 25, 0, 180, 1))

        return xi.effect.EVASION_DOWN
    end,
})

-----------------------------------
-- Rhino Attack
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.rhino_attack_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 1.0, 1.0, 1.0 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.BLUNT
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1
        params.attackMultiplier = { 2.0, 2.0, 2.0 }

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Rhino Guard
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.rhino_guard_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local duration = xi.mobskills.calculateDuration(skill:getTP(), 180, 540)
        skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.EVASION_BOOST, 25, 0, duration))

        return xi.effect.EVASION_BOOST
    end,
})

-----------------------------------
--Spoil
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.spoil_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local duration = xi.mobskills.calculateDuration(skill:getTP(), 180, 540)

        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STR_DOWN, 10, 9, duration))

        return xi.effect.STR_DOWN
    end,
})

-----------------------------------
-- Cursed Sphere
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.cursed_sphere_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getMainLvl() + 2
        params.fTP            = { 2, 2, 2 }
        params.element        = xi.element.DARK
        params.attackType     = xi.attackType.MAGICAL
        params.damageType     = xi.damageType.DARK
        params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

        local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Venom
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.venom_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getMainLvl() + 2
        params.fTP            = { 1.50, 1.50, 1.50 }
        params.element        = xi.element.WATER
        params.attackType     = xi.attackType.MAGICAL
        params.damageType     = xi.damageType.WATER
        params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

        local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)

            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 1, 3, 60) -- TODO: Capture duration
        end

        return info.damage
    end,
})

-----------------------------------
-- Sandblast
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.sandblast_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 40, 0, 90))

        return xi.effect.BLINDNESS
    end,
})

-----------------------------------
-- Sandpit
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.sandpit_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, 60))

        return xi.effect.BIND
    end,
})

-----------------------------------
-- Venom Spray
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.venom_spray_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local power    = 15
        local duration = 120

        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, power, 3, duration))

        return xi.effect.POISON
    end,
})

-----------------------------------
-- Mandibular Bite
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.mandibular_bite_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage       = mob:getWeaponDmg()
        params.numHits          = 1
        params.fTP              = { 1.5, 1.5, 1.5 }
        params.attackType       = xi.attackType.PHYSICAL
        params.damageType       = xi.damageType.PIERCING
        params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_1
        params.attackMultiplier = { 1.5, 1.5, 1.5 }
        params.canCrit          = true
        params.criticalChance = { 0.10, 0.20, 0.25 } -- TODO: Capture crit rate

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Soporific
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.soporific_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLEEP_I, 1, 0, 30))

        return xi.effect.SLEEP_I
    end,
})

-----------------------------------
-- Gloeosuccus
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.gloeosuccus_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local effectTable =
        {
            [1] = { effectId = xi.effect.SLOW, power = 1250, duration = 180, tier = 1 },
        }

        return xi.combat.action.executeMobskillStatusEffect(mob, target, skill, effectTable, {})
    end,
})

-----------------------------------
-- Palsy Pollen
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.palsy_pollen_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 30, 0, 60))

        return xi.effect.PARALYSIS
    end,
})

-----------------------------------
-- Geist Wall
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.geist_wall_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local dispel = target:dispelStatusEffect()

        if dispel == xi.effect.NONE then
            -- no effect
            skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
        else
            skill:setMsg(xi.msg.basic.SKILL_ERASE)
        end

        return dispel
    end,
})

-----------------------------------
-- Numbing Noise
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.numbing_noise_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, math.randomInt(5, 10)))

        return xi.effect.STUN
    end,
})

-----------------------------------
-- Nimble Snap
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.nimble_snap_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 3
        params.fTP            = { 1.0, 1.0, 1.0 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.SLASHING
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Cyclotail
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.cyclotail_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 1.5, 1.5, 1.5 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.SLASHING
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3 -- TODO: Capture shadowBehavior

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Toxic Spit
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.toxic_spit_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local power    = math.floor(mob:getMainLvl() / 5 + 3) -- TODO: Capture power at different levels to verify.
        local duration = 180

        -- TODO: Jug pet: Duration scales with TP.

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, power, 3, duration)

        return xi.effect.POISON
    end,
})

-----------------------------------
-- Double Claw
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.double_claw_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1 -- TODO: Capture numHits
        params.fTP            = { 1.5, 1.5, 1.5 } -- TODO: Capture fTP scalings
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.SLASHING
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1 -- TODO: captureshadowBehavior

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Grapple
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.grapple_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 1.5, 1.5, 1.5 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.BLUNT
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_4

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Filamented Hold
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.filamented_hold_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local effectTable =
        {
            [1] = { effectId = xi.effect.SLOW, power = 2500, duration = 120, tier = 8 },
        }

        return xi.combat.action.executeMobskillStatusEffect(mob, target, skill, effectTable, {})
    end,
})

-----------------------------------
-- Spinning Top
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.spinning_top_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 1.5, 1.5, 1.5 } -- TODO: Capture fTP scalings
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.SLASHING
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Chatic Eye
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.chaotic_eye_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.SILENCE, 1, 0, 60))

        return xi.effect.SILENCE
    end,
})

-----------------------------------
-- Blaster
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.blaster_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 70, 0, 60))

        return xi.effect.PARALYSIS
    end,
})

-----------------------------------
-- Suction
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.suction_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 1.0, 1.0, 1.0 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.BLUNT
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)

            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 4) -- TODO: Capture stun duration
        end

        return info.damage
    end,
})

-----------------------------------
-- Drainkiss
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.drainkiss_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage         = mob:getMainLvl() + 2
        params.fTP                = { 1.00, 1.25, 1.50 }
        params.element            = xi.element.NONE
        params.attackType         = xi.attackType.MAGICAL
        params.damageType         = xi.damageType.NONE
        params.shadowBehavior     = xi.mobskills.shadowBehavior.NUMSHADOWS_1
        params.skipMagicBonusDiff = true

        local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            skill:setMsg(xi.mobskills.mobDrainMove(mob, target, xi.mobskills.drainType.HP, info.damage))
        end

        return info.damage
    end,
})

-----------------------------------
-- Snow Cloud
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.snow_cloud_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getMainLvl() + 2
        params.fTP            = { 2.0, 2.0, 2.0 }
        params.element        = xi.element.ICE
        params.attackType     = xi.attackType.MAGICAL
        params.damageType     = xi.damageType.ICE
        params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

        local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)

            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 30, 0, 120)
        end

        return info.damage
    end,
})

-----------------------------------
-- Wild Carrot
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.wild_carrot_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.primaryMessage = xi.msg.basic.SELF_HEAL
        params.baseHeal       = mob:getMaxHP()
        params.fTP =
        {
            { tp = 1000, modifier = 104 / 1024 },
            { tp = 2000, modifier = 104 / 1024 },
            { tp = 3000, modifier = 104 / 1024 },
        }

        return xi.mobskills.mobHealMove(mob, target, skill, action, params)
    end,
})

-----------------------------------
-- Sudden Lunge
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.sudden_lunge_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 1.5, 1.5, 1.5 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.BLUNT
        params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)

            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 4) -- TODO: Capture stun duration
        end

        return info.damage
    end,
})

-----------------------------------
-- Spiral Spin
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.spiral_spin_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 2.0, 2.0, 2.0 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.SLASHING
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3 -- TODO: Capture shadowBehavior
        params.canCrit        = true
        params.criticalChance = { 0.10, 0.20, 0.25 } -- TODO: Capture crit rate

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)

            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ACCURACY_DOWN, 40, 0, 60)
        end

        return info.damage
    end,
})

-----------------------------------
-- Noisome Powder
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.noisome_powder_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ATTACK_DOWN, 40, 0, 120))

        return xi.effect.ATTACK_DOWN
    end,
})

-----------------------------------
-- Acid Mist
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.acid_mist_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getMainLvl() + 2
        params.fTP            = { 1.75, 2.00, 2.25 }
        params.element        = xi.element.WATER
        params.attackType     = xi.attackType.MAGICAL
        params.damageType     = xi.damageType.WATER
        params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

        local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)

            local power    = 50
            local duration = 120

            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ATTACK_DOWN, power, 0, duration)
        end

        return info.damage
    end,
})

-----------------------------------
-- TP Drainkiss
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.tp_drainkiss_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage           = target:getTP()
        params.fTP                  = { 0.500, 0.666, 0.833 } -- TODO: Need more capture samples
        -- Note: This has been observed to absorb less than 50% TP(1400~ @ Player: 3000TP, Mob 1000 TP)
        -- Also seen to absorb 2000+ TP at Player: 3000% TP, Mob 3000% TP. Interpolating the 2000 TP anchor linearly for now.
        params.element              = xi.element.NONE
        params.attackType           = xi.attackType.MAGICAL
        params.damageType           = xi.damageType.NONE
        params.shadowBehavior       = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
        params.skipDamageAdjustment = true
        params.skipMagicBonusDiff   = true
        params.skipStoneSkin        = true

        local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            skill:setMsg(xi.mobskills.mobDrainMove(mob, target, xi.mobskills.drainType.TP, info.damage))
        end

        return info.damage
    end,
})

-----------------------------------
-- Scythe Tail
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.scythe_tail_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 1.0, 1.0, 1.0 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.SLASHING
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)

            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 4) -- TODO: Capture stun duration
        end

        return info.damage
    end,
})

-----------------------------------
-- Ripper Fang
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.ripper_fang_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage       = mob:getWeaponDmg()
        params.numHits          = 1
        params.fTP              = { 1.5, 1.5, 1.5 }
        params.attackType       = xi.attackType.PHYSICAL
        params.damageType       = xi.damageType.BLUNT
        params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_1
        params.attackMultiplier = { 1.3, 1.3, 1.3 }

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Chomp Rush
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.chomp_rush_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 3
        params.fTP            = { 1.0, 1.0, 1.0 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.SLASHING
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)

            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 2500, 0, 180)
        end

        return info.damage
    end,
})

-----------------------------------
-- Charged Whisker
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.charged_whisker_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getMainLvl() + 2
        params.fTP            = { 3.00, 3.00, 3.00 }
        params.element        = xi.element.THUNDER
        params.attackType     = xi.attackType.MAGICAL
        params.damageType     = xi.damageType.THUNDER
        params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS
        -- TODO: BST Jug fTPs

        local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Purulent Ooze
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.purulent_ooze_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getMainLvl() + 2
        params.fTP            = { 1.5, 1.5, 1.5 }
        params.element        = xi.element.WATER
        params.attackType     = xi.attackType.MAGICAL
        params.damageType     = xi.damageType.WATER
        params.shadowBehavior = xi.mobskills.shadowBehavior.WIPE_SHADOWS

        local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)

            -- TODO: Capture durations
            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIO, 12, 3, 120, 0, 10)
            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAX_HP_DOWN, 10, 0, 120)
        end

        return info.damage
    end,
})

-----------------------------------
-- Corrosive Ooze
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.corrosive_ooze_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getMainLvl() + 2
        params.fTP            = { 1.5, 1.5, 1.5 }
        params.element        = xi.element.WATER
        params.attackType     = xi.attackType.MAGICAL
        params.damageType     = xi.damageType.WATER
        params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

        local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)

            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ATTACK_DOWN, 33, 0, 120)
            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEFENSE_DOWN, 33, 0, 120)
        end

        return info.damage
    end,
})

-----------------------------------
-- Back Heel
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.back_heel_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 3.0, 3.0, 3.0 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.BLUNT
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Jettatura
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.jettatura_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.TERROR, 1, 0, math.randomInt(10, 15)))

        return xi.effect.TERROR
    end,
})

-----------------------------------
-- Choke Breath
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.choke_breath_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = 100
        params.numHits        = 1
        params.fTP            = { 1.0, 1.0, 1.0 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.SLASHING
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3 -- TODO: Capture shadowBehavior

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)

            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 25, 0, 30)
            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 30)
        end

        return info.damage
    end,
})

-----------------------------------
-- Fantod
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.fantod_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local subPower = 1 -- Special formula for boost increasing base damage

        skill:setMsg(xi.mobskills.mobBuffMove(mob, xi.effect.BOOST, 400, 0, 180, nil, subPower))

        return xi.effect.BOOST
    end,
})

-----------------------------------
-- Tortoise Stomp
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.tortoise_stomp_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 1.0, 1.0, 1.0 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.BLUNT
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1
        -- Note: ShadowBehavior may vary depending on AoE Type(May vary between NMs)

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)

            -- TODO: Random, resisted, or scales with TP?
            local duration = math.randomInt(120, 180)
            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEFENSE_DOWN, 25, 0, duration)
        end

        return info.damage
    end,
})

-----------------------------------
-- Harden Shell
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.harden_shell_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local duration = math.randomInt(60, 180)
        local power = 33

        skill:setMsg(xi.mobskills.mobBuffMove(target, xi.effect.DEFENSE_BOOST, power, 0, duration))

        return xi.effect.DEFENSE_BOOST
    end,
})

-----------------------------------
-- Aqua Breath
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.aqua_breath_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.percentMultipier = 0.10
        params.damageCap        = 500
        params.bonusDamage      = 100
        params.mAccuracyBonus   = { 0, 0, 0 }
        params.resistStat       = xi.mod.INT
        params.element          = xi.element.WATER
        params.attackType       = xi.attackType.BREATH
        params.damageType       = xi.damageType.WATER
        params.shadowBehavior   = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

        local info = xi.mobskills.mobBreathMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Wing Slap
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.wing_slap_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 4
        params.fTP            = { 0.25, 0.25, 0.25 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.BLUNT
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_4

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)

            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, 4) -- TODO: Capture stun duration
        end

        return info.damage
    end,
})

-----------------------------------
-- Beak Lunge
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.beak_lunge_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 2.0, 2.0, 2.0 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.PIERCING
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Intimidate
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.intimidate_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        skill:setMsg(xi.mobskills.mobGazeMove(mob, target, xi.effect.SLOW, 1250, 0, 120))

        return xi.effect.SLOW
    end,
})

-----------------------------------
-- Recoil Dive
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.recoil_dive_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 2.0, 2.0, 2.0 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.SLASHING
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3 -- TODO: Capture shadowBehavior
        params.canCrit        = true
        params.criticalChance = { 0.10, 0.20, 0.25 } -- TODO: Capture crit rate

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Water Wall
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.water_wall_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        skill:setMsg(xi.mobskills.mobBuffMove(target, xi.effect.DEFENSE_BOOST, 100, 0, 90)) -- The duration of this ability may vary all the way to 9 minutes with a HEAVY weight towards 90 seconds.

        return xi.effect.DEFENSE_BOOST
    end,
})

-----------------------------------
-- Somersault
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.somersault_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage       = mob:getWeaponDmg()
        params.numHits          = 1
        params.fTP              = { 3.0, 3.0, 3.0 } -- TODO: Capture fTPs
        params.attackType       = xi.attackType.PHYSICAL
        params.damageType       = xi.damageType.BLUNT
        params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_1
        params.attackMultiplier = { 1.5, 1.5, 1.5 }

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Pecking Flurry
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.pecking_flurry_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 4
        params.fTP            = { 0.75, 0.75, 0.75 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.SLASHING
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_4
        -- TODO: Possible accuracy multiplier

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Sickle Slash
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.sickle_slash_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage       = mob:getWeaponDmg()
        params.numHits          = 1
        params.fTP              = { 2.0, 2.0, 2.0 }
        params.attackType       = xi.attackType.PHYSICAL
        params.damageType       = xi.damageType.BLUNT
        params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_1
        params.attackMultiplier = { 0.5, 1.5, 2.5 }
        params.canCrit          = true
        params.criticalChance   = { 1.0, 1.0, 1.0 }

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Acid Spray
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.acid_spray_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getMainLvl() + 2
        params.fTP            = { 1.00, 1.00, 1.00 }
        params.element        = xi.element.WATER
        params.attackType     = xi.attackType.MAGICAL
        params.damageType     = xi.damageType.WATER
        params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

        local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)

            local power = math.floor(mob:getMainLvl() / 10 * 2)

            xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, power, 3, 60)
        end

        return info.damage
    end,
})

-----------------------------------
-- Spider Web
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.spider_web_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local effectTable =
        {
            [1] = { effectId = xi.effect.SLOW, power = 3000, duration = 90, tier = 8 },
        }

        return xi.combat.action.executeMobskillStatusEffect(mob, target, skill, effectTable, {})
    end,
})

-----------------------------------
-- Fluid Toss
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.fluid_toss_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        -- TODO: Physical or Ranged PDIF?
        params.baseDamage       = mob:getWeaponDmg()
        params.numHits          = 1
        params.fTP              = { 1.5, 1.5, 1.5 }
        params.attackType       = xi.attackType.PHYSICAL
        params.damageType       = xi.damageType.SLASHING
        params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_1
        params.attackMultiplier = { 2.0, 2.0, 2.0 }
        params.canCrit          = true
        params.criticalChance = { 0.10, 0.20, 0.25 } -- TODO: Capture crit rate

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Fluid Spread
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.fluid_spread_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage       = mob:getWeaponDmg()
        params.numHits          = 1
        params.fTP              = { 1.0, 1.0, 1.0 } -- TODO: Capture fTPs
        params.attackType       = xi.attackType.PHYSICAL
        params.damageType       = xi.damageType.SLASHING
        params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_3 -- TODO: Capture shadowBehavior
        params.attackMultiplier = { 1.5, 1.5, 1.5 }

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Digest
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.digest_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage         = mob:getMainLvl() + 2
        params.fTP                = { 2.0, 2.0, 2.0 }
        params.element            = xi.element.NONE
        params.attackType         = xi.attackType.MAGICAL
        params.damageType         = xi.damageType.NONE
        params.shadowBehavior     = xi.mobskills.shadowBehavior.NUMSHADOWS_1
        params.skipMagicBonusDiff = true

        local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            skill:setMsg(xi.mobskills.mobDrainMove(mob, target, xi.mobskills.drainType.HP, info.damage))
        end

        return info.damage
    end,
})

-----------------------------------
-- Crossthrash
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.crossthrash_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 2.0, 2.0, 2.0 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.SLASHING
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_3 -- TODO: Capture shadowBehavior

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)

            target:dispelStatusEffect()
        end

        return info.damage
    end,
})

-----------------------------------
-- Predatory Glare
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.predatory_glare_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, math.randomInt(3, 8)))

        return xi.effect.STUN
    end,
})

-----------------------------------
-- Hoof Volley
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.hoof_volley_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local params = {}

        params.baseDamage     = mob:getWeaponDmg()
        params.numHits        = 1
        params.fTP            = { 4.0, 4.0, 4.0 }
        params.attackType     = xi.attackType.PHYSICAL
        params.damageType     = xi.damageType.BLUNT
        params.shadowBehavior = xi.mobskills.shadowBehavior.NUMSHADOWS_1

        local info = xi.mobskills.mobPhysicalMove(mob, target, skill, action, params)

        if xi.mobskills.processDamage(mob, target, skill, action, info) then
            target:takeDamage(info.damage, mob, info.attackType, info.damageType)
        end

        return info.damage
    end,
})

-----------------------------------
-- Nihility Song
-----------------------------------
m:addOverrideByEra('xi.actions.mobskills.nihility_song_jugpet.onMobWeaponSkill', {
    [xi.expansion.SOA] = function(mob, target, skill, action)
        local dispel =  target:dispelStatusEffect(bit.bor(xi.effectFlag.DISPELABLE, xi.effectFlag.FOOD))

        if dispel == xi.effect.NONE then
            -- no effect
            skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
        else
            skill:setMsg(xi.msg.basic.SKILL_ERASE)
        end

        return dispel
    end,
})
