-----------------------------------
-- WoTG Era Automaton Weaponskills
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('wotg_automaton', xi.pre(xi.expansion.ABYSSEA))

-----------------------------------
-- Arcuballista
-----------------------------------
-- TODO: find a patch note or source for this change
m:addOverride('xi.actions.abilities.pets.automaton.arcuballista.onAutomatonAbility', function(target, automaton, skill, master, action)
    local params = {}

    params.baseDamage       = xi.automaton.getRangedBaseDamage(automaton)
    params.numHits          = 1
    params.fTP              = { 2.5, 3.0, 4.0 }
    params.dex_wSC          = 0.30
    params.accuracyModifier = { 100, 100, 100 }
    params.attackType       = xi.attackType.RANGED
    params.damageType       = xi.damageType.PIERCING
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.skipParry        = true
    params.skipGuard        = true
    params.skipBlock        = true

    xi.automaton.applyFlameHolder(automaton, params.fTP)

    local info = xi.mobskills.mobRangedMove(automaton, target, skill, action, params)

    if xi.mobskills.processDamage(automaton, target, skill, action, info) then
        target:takeDamage(info.damage, automaton, info.attackType, info.damageType)
    end

    return info.damage
end)

-----------------------------------
-- Armor Piercer
-----------------------------------
-- TODO: find a patch note or source for this change
m:addOverride('xi.actions.abilities.pets.automaton.armor_piercer.onAutomatonAbility', function(target, automaton, skill, master, action)
    local params = {}

    params.baseDamage       = xi.automaton.getRangedBaseDamage(automaton)
    params.numHits          = 1
    params.fTP              = { 3.0, 3.5, 4.0 }
    params.dex_wSC          = 0.30
    params.ignoreDefense    = { 0.5, 0.5, 0.5 }
    params.accuracyModifier = { 100, 100, 100 }
    params.attackType       = xi.attackType.RANGED
    params.damageType       = xi.damageType.PIERCING
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.skipParry        = true
    params.skipGuard        = true
    params.skipBlock        = true

    xi.automaton.applyFlameHolder(automaton, params.fTP)

    local info = xi.mobskills.mobRangedMove(automaton, target, skill, action, params)

    if xi.mobskills.processDamage(automaton, target, skill, action, info) then
        target:takeDamage(info.damage, automaton, info.attackType, info.damageType)
    end

    return info.damage
end)

-----------------------------------
-- Bone Crusher
-----------------------------------
-- TODO: find a patch note or source for this change
m:addOverride('xi.actions.abilities.pets.automaton.bone_crusher.onAutomatonAbility', function(target, automaton, skill, master, action)
    local params = {}

    params.baseDamage     = automaton:getWeaponDmg()
    params.numHits        = utils.clamp(3 + xi.automaton.getExtraHits(automaton, 3), 1, 8)
    params.fTP            = { 1.5, 1.5, 1.5 }
    params.vit_wSC        = 0.30
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.shadowBehavior = params.numHits

    if target:isUndead() then
        params.fTP = { 2.5, 2.5, 2.5 }
    end

    xi.automaton.applyFlameHolder(automaton, params.fTP)

    local info = xi.mobskills.mobPhysicalMove(automaton, target, skill, action, params)

    if xi.mobskills.processDamage(automaton, target, skill, action, info) then
        target:takeDamage(info.damage, automaton, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(automaton, target, xi.effect.STUN, 1, 0, 4)
    end

    return info.damage
end)

-----------------------------------
-- Cannibal Blade
-----------------------------------
-- TODO: find a patch note or source for this change
m:addOverride('xi.actions.abilities.pets.automaton.cannibal_blade.onAutomatonAbility', function(target, automaton, skill, master, action)
    local params = {}

    params.baseDamage         = automaton:getSkillLevel(xi.skill.AUTOMATON_MELEE) / 9.2
    params.numHits            = 1
    params.fTP                = { 11.0, 12.5, 14.0 }
    params.attackType         = xi.attackType.PHYSICAL
    params.damageType         = xi.damageType.SLASHING
    params.shadowBehavior     = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.guaranteedFirstHit = true
    params.skipFSTR           = true
    params.skipPDIF           = true

    xi.automaton.applyFlameHolder(automaton, params.fTP)

    local info = xi.mobskills.mobPhysicalMove(automaton, target, skill, action, params)

    if xi.mobskills.processDamage(automaton, target, skill, action, info) then
        target:takeDamage(info.damage, automaton, info.attackType, info.damageType)

        if not target:isUndead() then
            automaton:addHP(info.damage)
        end
    end

    -- Does not return TP.
    automaton:setTP(0)

    return info.damage
end)

-----------------------------------
-- Chimera Ripper
-----------------------------------
-- TODO: find a patch note or source for this change
m:addOverride('xi.actions.abilities.pets.automaton.chimera_ripper.onAutomatonAbility', function(target, automaton, skill, master, action)
    local params = {}

    params.baseDamage       = automaton:getWeaponDmg()
    params.numHits          = utils.clamp(1 + xi.automaton.getExtraHits(automaton, 1), 1, 8)
    params.fTP              = { 2.0, 2.5, 3.0 }
    params.str_wSC          = 0.30
    params.accuracyModifier = { 100, 100, 100 }
    params.attackType       = xi.attackType.PHYSICAL
    params.damageType       = xi.damageType.SLASHING
    params.shadowBehavior   = params.numHits

    xi.automaton.applyFlameHolder(automaton, params.fTP)

    local info = xi.mobskills.mobPhysicalMove(automaton, target, skill, action, params)

    if xi.mobskills.processDamage(automaton, target, skill, action, info) then
        target:takeDamage(info.damage, automaton, info.attackType, info.damageType)
    end

    return info.damage
end)

-----------------------------------
-- Daze
-----------------------------------
-- TODO: find a patch note or source for this change
m:addOverride('xi.actions.abilities.pets.automaton.daze.onAutomatonAbility', function(target, automaton, skill, master, action)
    local params = {}

    params.baseDamage       = xi.automaton.getRangedBaseDamage(automaton)
    params.numHits          = 1
    params.fTP              = { 5.0, 5.5, 6.0 }
    params.dex_wSC          = 0.30
    params.accuracyModifier = { 150, 150, 150 }
    params.attackType       = xi.attackType.RANGED
    params.damageType       = xi.damageType.PIERCING
    params.shadowBehavior   = xi.mobskills.shadowBehavior.NUMSHADOWS_1
    params.skipParry        = true
    params.skipGuard        = true
    params.skipBlock        = true

    xi.automaton.applyFlameHolder(automaton, params.fTP)

    local info = xi.mobskills.mobRangedMove(automaton, target, skill, action, params)

    if xi.mobskills.processDamage(automaton, target, skill, action, info) then
        target:takeDamage(info.damage, automaton, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(automaton, target, xi.effect.STUN, 1, 0, 4)
    end

    return info.damage
end)

-----------------------------------
-- Knockout
-----------------------------------
-- TODO: find a patch note or source for this change
m:addOverride('xi.actions.abilities.pets.automaton.knockout.onAutomatonAbility', function(target, automaton, skill, master, action)
    local params = {}

    params.numHits          = utils.clamp(1 + xi.automaton.getExtraHits(automaton, 1), 1, 8)
    params.fTP              = { 4.0, 4.5, 5.0 }
    params.agi_wSC          = 0.40
    params.accuracyModifier = { 50, 50, 50 }
    params.attackType       = xi.attackType.PHYSICAL
    params.damageType       = xi.damageType.BLUNT
    params.shadowBehavior   = params.numHits

    xi.automaton.applyFlameHolder(automaton, params.fTP)

    local info = xi.mobskills.mobPhysicalMove(automaton, target, skill, action, params)

    if xi.mobskills.processDamage(automaton, target, skill, action, info) then
        target:takeDamage(info.damage, automaton, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(automaton, target, xi.effect.EVASION_DOWN, 20, 0, 30)
    end

    return info.damage
end)

-----------------------------------
-- Magic Mortar
-----------------------------------
-- TODO: find a patch note or source for this change
m:addOverride('xi.actions.abilities.pets.automaton.magic_mortar.onAutomatonAbility', function(target, automaton, skill, master, action)
    local params = {}

    params.baseDamage     = automaton:getMaxHP() - automaton:getHP()
    params.fTP            = { 0.50, 0.75, 1.00 }
    params.element        = xi.element.NONE
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.ELEMENTAL
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    -- Flame Holder multiplies the base damage of Magic Mortar. Gives a 25% boost at 3 Fire Maneuvers.
    local flameHolderModifier = 1.0 + (automaton:getMod(xi.mod.WEAPONSKILL_DAMAGE_BASE) - 100) / 1000

    if flameHolderModifier > 1.0 then
        params.baseDamage = math.floor(params.baseDamage * flameHolderModifier)
    end

    local info = xi.mobskills.mobMagicalMove(automaton, target, skill, action, params)

    if xi.mobskills.processDamage(automaton, target, skill, action, info) then
        target:takeDamage(info.damage, automaton, info.attackType, info.damageType)
    end

    return info.damage
end)

-----------------------------------
-- Slapstick
-----------------------------------
-- TODO: find a patch note or source for this change
m:addOverride('xi.actions.abilities.pets.automaton.slapstick.onAutomatonAbility', function(target, automaton, skill, master, action)
    local params = {}

    params.numHits          = utils.clamp(3 + xi.automaton.getExtraHits(automaton, 3), 1, 8)
    params.fTP              = { 1.0, 1.0, 1.0 }
    params.str_wSC          = 0.20
    params.dex_wSC          = 0.20
    params.accuracyModifier = { 0, 30, 50 }
    params.attackType       = xi.attackType.PHYSICAL
    params.damageType       = xi.damageType.BLUNT
    params.shadowBehavior   = params.numHits

    xi.automaton.applyFlameHolder(automaton, params.fTP)

    local info = xi.mobskills.mobPhysicalMove(automaton, target, skill, action, params)

    if xi.mobskills.processDamage(automaton, target, skill, action, info) then
        target:takeDamage(info.damage, automaton, info.attackType, info.damageType)
    end

    return info.damage
end)

-----------------------------------
-- String Clipper
-----------------------------------
-- TODO: find a patch note or source for this change
m:addOverride('xi.actions.abilities.pets.automaton.string_clipper.onAutomatonAbility', function(target, automaton, skill, master, action)
    local params = {}

    params.baseDamage       = automaton:getWeaponDmg()
    params.numHits          = utils.clamp(2 + xi.automaton.getExtraHits(automaton, 2), 1, 8)
    params.fTP              = { 2.0, 2.0, 2.0 }
    params.str_wSC          = 0.15
    params.dex_wSC          = 0.15
    params.attackMultiplier = { 1.5, 1.5, 1.5 }
    params.accuracyModifier = { 0, 50, 100 }
    params.attackType       = xi.attackType.PHYSICAL
    params.damageType       = xi.damageType.SLASHING
    params.shadowBehavior   = params.numHits

    xi.automaton.applyFlameHolder(automaton, params.fTP)

    local info = xi.mobskills.mobPhysicalMove(automaton, target, skill, action, params)

    if xi.mobskills.processDamage(automaton, target, skill, action, info) then
        target:takeDamage(info.damage, automaton, info.attackType, info.damageType)
    end

    return info.damage
end)
