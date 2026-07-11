-----------------------------------
-- Attachment module
-- Recreates attachment effects in the WoTG Era.
-----------------------------------
require('modules/module_utils')
require('scripts/globals/automaton')
-----------------------------------

local moduleName = 'attachments'

if xi.module.isContentEnabled('ABYSSEA') then
    return { name = moduleName }
end

local m = Module:new(moduleName)

-- Reduces Enmity boost from Strobe                                 : https://wiki.ffo.jp/html/8610.html
-- Reduces Store TP from Inhibitor                                  : https://wiki.ffo.jp/html/8625.html
-- Changes Armor Plate and Armor Plate II to Defense instead of PDT : https://wiki.ffo.jp/html/9070.html
-- Adds a Ranged Attack Penalty to Drum Magazine.                   : https://wiki.ffo.jp/html/8882.html
-- Changes Turbo Charger Haste to Gear Haste instead of Magic       : https://wiki.ffo.jp/html/8627.html
-- Adds Burden to Tactical Processor                                : https://wiki.ffo.jp/html/13527.html
-- Reduces scaling from Volt Gun                                    : https://wiki.ffo.jp/html/8752.html
-- Reduces Burden Decay From Heatsink                               : https://wiki.ffo.jp/html/8629.html
-- Reduces the potency of Steam Jackets Damage Reduction            : https://wiki.ffo.jp/html/15352.html
xi.automaton.attachmentModifiers['strobe'            ] = { { modifier = xi.mod.ENMITY,                      values = {   5,   15,   25,   40 }, opticFiber = true  }, }
xi.automaton.attachmentModifiers['inhibitor'         ] = { { modifier = xi.mod.STORETP,                     values = {   5,   10,   15,   20 }, opticFiber = true  }, }
xi.automaton.attachmentModifiers['armor_plate'       ] = { { modifier = xi.mod.DEFP,                        values = {  10,   15,   20,   25 }, opticFiber = true  }, }
xi.automaton.attachmentModifiers['armor_plate_ii'    ] = { { modifier = xi.mod.DEFP,                        values = {  20,   25,   30,   35 }, opticFiber = true  }, }
xi.automaton.attachmentModifiers['drum_magazine'     ] = { { modifier = xi.mod.AUTO_RANGED_DELAY,           values = {   2,    4,    6,    8 }, opticFiber = false },
                                                            { modifier = xi.mod.RACC,                        values = { -15,  -30,  -50,  -75 }, opticFiber = false }, }
xi.automaton.attachmentModifiers['flame_holder'      ] = { { modifier = xi.mod.WEAPONSKILL_DAMAGE_BASE,     values = {   0,  125,  150,  175 }, opticFiber = true  }, }
xi.automaton.attachmentModifiers['ice_maker'         ] = { { modifier = xi.mod.AUTO_MAB_COEFFICIENT,        values = {   0,   20,   40,   60 }, opticFiber = true  }, }
xi.automaton.attachmentModifiers['turbo_charger'     ] = { { modifier = xi.mod.HASTE_GEAR,                  values = { 500, 1500, 2000, 2500 }, opticFiber = true  }, }
xi.automaton.attachmentModifiers['tactical_processor'] = { { modifier = xi.mod.AUTO_DECISION_DELAY,         values = {  50,   70,   85,  115 }, opticFiber = false },
                                                            { modifier = xi.mod.OVERLOAD_THRESH,             values = {  -5,   -5,   -5,   -5 }, opticFiber = false }, }
xi.automaton.attachmentModifiers['volt_gun'          ] = { { modifier = xi.mod.VOLT_GUN_POTENCY,            values = {   0,    0,    0,    0 }, opticFiber = false }, }
xi.automaton.attachmentModifiers['heatsink'          ] = { { modifier = xi.mod.BURDEN_DECAY,                values = {   1,    1,    1,    1 }, opticFiber = false }, }
xi.automaton.attachmentModifiers['steam_jacket'      ] = { { modifier = xi.mod.AUTO_STEAM_JACKET_REDUCTION, values = {  25,   35,   40,   60 }, opticFiber = true  }, }

-- Reduces potency of Auto Repair Kit II and removed level based scaling from Mana Tank : https://wiki.ffo.jp/html/19739.html
xi.automaton.repairKit.data['auto-repair_kit_ii' ] = { id = 196, hpBoost = 2, regenBase   = { 0, 2, 3, 4 }, regenMultiplier   = { 0, 0.4, 0.6, 0.8 } }
xi.automaton.manaTank.data ['mana_tank'          ] = { id = 225, mpBoost = 1, refreshBase = { 0, 1, 2, 3 }, refreshMultiplier = { 0, 0.0, 0.0, 0.0 } }
xi.automaton.manaTank.data ['mana_tank_ii'       ] = { id = 228, mpBoost = 2, refreshBase = { 0, 2, 3, 4 }, refreshMultiplier = { 0, 0.0, 0.0, 0.0 } }

-----------------------------------
-- Flame Holder - Reduces Flame Holder Scaling, and consumes all Fire Maneuvers on weaponskill execution. https://wiki.ffo.jp/html/11183.html
-----------------------------------
local validFlameHolderSkills = set
{
    xi.mobSkill.ARCUBALLISTA_AUTOMATON,
    xi.mobSkill.ARMOR_PIERCER_AUTOMATON,
    xi.mobSkill.ARMOR_SHATTERER_AUTOMATON,
    xi.mobSkill.BONE_CRUSHER_AUTOMATON,
    xi.mobSkill.CANNIBAL_BLADE_AUTOMATON,
    xi.mobSkill.CHIMERA_RIPPER_AUTOMATON,
    xi.mobSkill.DAZE_AUTOMATON,
    xi.mobSkill.KNOCKOUT_AUTOMATON,
    xi.mobSkill.MAGIC_MORTAR_AUTOMATON,
    xi.mobSkill.SLAPSTICK_AUTOMATON,
    xi.mobSkill.STRING_CLIPPER_AUTOMATON,
    xi.mobSkill.STRING_SHREDDER_AUTOMATON,
}

m:addOverride('xi.actions.abilities.pets.attachments.flame_holder.onEquip', function(pet, attachment)
    pet:addListener('WEAPONSKILL_STATE_EXIT', 'AUTO_FLAME_HOLDER_END', function(automaton, skillId, wasExecuted)
        if not validFlameHolderSkills[skillId] then
            return
        end

        if not wasExecuted then
            return
        end

        local master = automaton:getMaster()

        if not master then
            return
        end

        -- Consume all Fire Maneuvers on weaponskill execution.
        local fireManeuvers = master:countEffect(xi.effect.FIRE_MANEUVER)

        for i = 1, fireManeuvers do
            master:delStatusEffectSilent(xi.effect.FIRE_MANEUVER)
        end

        master:updateAttachments()
    end)

    xi.automaton.onAttachmentEquip(pet, attachment)
end)

m:addOverride('xi.actions.abilities.pets.attachments.flame_holder.onUnequip', function(pet, attachment)
    xi.automaton.onAttachmentUnequip(pet, attachment)
    pet:removeListener('AUTO_FLAME_HOLDER_END')
end)

-----------------------------------
-- Ice Maker - Reduces Magic Attack Bonus from Ice Maker, and consumes all Ice Maneuvers on magic attack execution. https://wiki.ffo.jp/html/11198.html
-----------------------------------
local validIceMakerSpells = set
{
    xi.magic.spell.FIRE,
    xi.magic.spell.FIRE_II,
    xi.magic.spell.FIRE_III,
    xi.magic.spell.FIRE_IV,
    xi.magic.spell.FIRE_V,
    xi.magic.spell.BLIZZARD,
    xi.magic.spell.BLIZZARD_II,
    xi.magic.spell.BLIZZARD_III,
    xi.magic.spell.BLIZZARD_IV,
    xi.magic.spell.BLIZZARD_V,
    xi.magic.spell.AERO,
    xi.magic.spell.AERO_II,
    xi.magic.spell.AERO_III,
    xi.magic.spell.AERO_IV,
    xi.magic.spell.AERO_V,
    xi.magic.spell.STONE,
    xi.magic.spell.STONE_II,
    xi.magic.spell.STONE_III,
    xi.magic.spell.STONE_IV,
    xi.magic.spell.STONE_V,
    xi.magic.spell.THUNDER,
    xi.magic.spell.THUNDER_II,
    xi.magic.spell.THUNDER_III,
    xi.magic.spell.THUNDER_IV,
    xi.magic.spell.THUNDER_V,
    xi.magic.spell.WATER,
    xi.magic.spell.WATER_II,
    xi.magic.spell.WATER_III,
    xi.magic.spell.WATER_IV,
    xi.magic.spell.WATER_V,
}

m:addOverride('xi.actions.abilities.pets.attachments.ice_maker.onEquip', function(pet, attachment)
    pet:addListener('MAGIC_USE', 'AUTO_ICE_MAKER_USE', function(automaton, target, spell, action)
        if not validIceMakerSpells[spell:getID()] then
            return
        end

        local master = automaton:getMaster()

        if not master then
            return
        end

        local iceManeuvers = master:countEffect(xi.effect.ICE_MANEUVER)

        for i = 1, iceManeuvers do
            master:delStatusEffectSilent(xi.effect.ICE_MANEUVER)
        end

        master:updateAttachments()
    end)

    xi.automaton.onAttachmentEquip(pet, attachment)
end)

m:addOverride('xi.actions.abilities.pets.attachments.ice_maker.onUnequip', function(pet, attachment)
    xi.automaton.onAttachmentUnequip(pet, attachment)
    pet:removeListener('AUTO_ICE_MAKER_USE')
end)

-----------------------------------
-- Replicator - Reduces amount of absorbs granted by Replicator, and changes them to Blink from Utsusemi. Also consumes Wind Maneuvers. https://wiki.ffo.jp/html/12225.html
-----------------------------------
local shadowTable =
{
    [1] = 2,
    [2] = 3,
    [3] = 4,
}

m:addOverride('xi.actions.abilities.pets.automaton.replicator.onAutomatonAbilityCheck', function(target, automaton, skill)
    return 0
end)

m:addOverride('xi.actions.abilities.pets.automaton.replicator.onAutomatonAbility', function(target, automaton, skill, master, action)
    local windManeuvers = xi.automaton.getManeuverCount(master, master:countEffect(xi.effect.WIND_MANEUVER))
    local shadows       = shadowTable[windManeuvers]

    automaton:addRecast(xi.recast.ABILITY, skill:getID(), 60)

    for i = 1, windManeuvers do
        master:delStatusEffectSilent(xi.effect.WIND_MANEUVER)
    end

    master:updateAttachments()

    if
        shadows and
        target:addStatusEffect(xi.effect.BLINK, { power = shadows, duration = 300, origin = automaton })
    then
        skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end

    return xi.effect.BLINK
end)

-----------------------------------
-- Shock Absorber - Reduces the potency of the stoneskin effect and removes scaling. https://wiki.ffo.jp/html/12927.html
-----------------------------------
m:addOverride('xi.actions.abilities.pets.automaton.shock_absorber.onAutomatonAbilityCheck', function(target, automaton, skill)
    return 0
end)

m:addOverride('xi.actions.abilities.pets.automaton.shock_absorber.onAutomatonAbility', function(target, automaton, skill, master, action)
    automaton:addRecast(xi.recast.ABILITY, skill:getID(), 180)

    if target:addStatusEffect(xi.effect.STONESKIN, { power = 100, duration = 180, origin = automaton, tier = 4 }) then
        skill:setMsg(xi.msg.basic.SKILL_GAIN_EFFECT)
    else
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT)
    end

    return xi.effect.STONESKIN
end)

-----------------------------------
-- Shield Bash - Removes gaurunteed hit chance while Hammermill is equipped. https://wiki.ffo.jp/html/12156.html
-----------------------------------
local shieldBashSlowTable =
{
    [1] = { tier = 4, duration = 30 },
    [2] = { tier = 5, duration = 50 },
    [3] = { tier = 6, duration = 70 },
}

local function applyHammermillSlow(automaton, target, skill, master)
    local power = automaton:getMod(xi.mod.AUTO_SHIELD_BASH_SLOW) * 100
    if power <= 0 then
        return
    end

    local slowTier = shieldBashSlowTable[master and xi.automaton.getManeuverCount(master, master:countEffect(xi.effect.EARTH_MANEUVER)) or 0]

    local params =
    {
        [1] = { effectId = xi.effect.SLOW, power = power, duration = slowTier.duration, tier = slowTier.tier },
    }

    xi.combat.action.executeMobskillStatusEffect(automaton, target, skill, params, { messageBypass = true })
end

m:addOverride('xi.actions.abilities.pets.automaton.shield_bash.onAutomatonAbilityCheck', function(target, automaton, skill)
    return 0
end)

-----------------------------------
-- Hammermill
-----------------------------------
m:addOverride('xi.actions.abilities.pets.automaton.shield_bash.onAutomatonAbility', function(target, automaton, skill, master, action)
    local params = {}

    params.baseDamage     = automaton:getWeaponDmg()
    params.numHits        = utils.clamp(1 + xi.automaton.getExtraHits(automaton, 1), 1, 8)
    params.fTP            = { 1.0, 1.0, 1.0 }
    params.attackType     = xi.attackType.PHYSICAL
    params.damageType     = xi.damageType.BLUNT
    params.shadowBehavior = params.numHits

    local hammermillEquipped = automaton:hasAttachmentSet(xi.item.HAMMERMILL_ATTACHMENT)

    if hammermillEquipped then
        local shieldBashBonus = 1.0 + automaton:getMod(xi.mod.SHIELD_BASH) / 100

        params.fTP =
        {
            params.fTP[1] * shieldBashBonus,
            params.fTP[2] * shieldBashBonus,
            params.fTP[3] * shieldBashBonus,
        }
    end

    local info = xi.mobskills.mobPhysicalMove(automaton, target, skill, action, params)

    if xi.mobskills.processDamage(automaton, target, skill, action, info) then
        target:takeDamage(info.damage, automaton, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(automaton, target, xi.effect.STUN, 1, 0, 6)

        if hammermillEquipped then
            applyHammermillSlow(automaton, target, skill, master)
        end
    end

    return info.damage
end)

-----------------------------------
-- Analyzer - Caps the amount of skills that can be analyzed to 1. https://wiki.ffo.jp/html/10746.html
-----------------------------------
m:addOverride('xi.actions.abilities.pets.attachments.analyzer.onEquip', function(pet, attachment)
    pet:setLocalVar('analyzedSkill1', 0)

    pet:addListener('WEAPONSKILL_TAKE', 'ANALYZER_WEAPONSKILL_TAKE', function(mob, target, skill, tp, action)
        local analyzerModifier = target:getMod(xi.mod.AUTO_ANALYZER)
        local incomingSkill    = skill:getID()

        if analyzerModifier <= 0 then
            return
        end

        local analyzedSkill = target:getLocalVar('analyzedSkill1')

        if incomingSkill == analyzedSkill then
            return
        end

        if incomingSkill ~= analyzedSkill then
            target:setLocalVar('analyzedSkill1', incomingSkill)
        end
    end)

    xi.automaton.onAttachmentEquip(pet, attachment)
end)

m:addOverride('xi.actions.abilities.pets.attachments.analyzer.onUnequip', function(pet, attachment)
    pet:setLocalVar('analyzedSkill1', 0)

    pet:removeListener('ANALYZER_WEAPONSKILL_TAKE')

    xi.automaton.onAttachmentUnequip(pet, attachment)
end)

m:addOverride('xi.actions.abilities.pets.attachments.analyzer.onManeuverGain', function(pet, attachment, maneuvers)
end)

m:addOverride('xi.actions.abilities.pets.attachments.analyzer.onManeuverLose', function(pet, attachment, maneuvers)
end)

m:addOverride('xi.actions.abilities.pets.attachments.analyzer.onUpdate', function(pet, attachment, maneuvers)
end)

m:addOverride('utils.handleAutomatonAutoAnalyzer', function(actor, skill, damage)
    local analyzerModifier = actor:getMod(xi.mod.AUTO_ANALYZER)

    if analyzerModifier <= 0 then
        return damage
    end

    local automatonId = actor:getID()

    if not automatonId then
        return damage
    end

    local automatonMaster = actor:getMaster()

    if not automatonMaster then
        return damage
    end

    local incomingSkill = skill:getID()
    local analyzedSkill = actor:getLocalVar('analyzedSkill1')

    if incomingSkill == analyzedSkill then
        local earthManeuvers  = xi.automaton.getManeuverCount(automatonMaster, automatonMaster:countEffect(xi.effect.EARTH_MANEUVER))
        local damageReduction = 10 + 10 * earthManeuvers

        return math.floor(damage * (100 - damageReduction) / 100)
    end

    return damage
end)

-----------------------------------
-- Eraser - Changes Eraser to consume all Maneuvers on activation. https://wiki.ffo.jp/html/5365.html
-----------------------------------
local maneuvers =
{
    xi.effect.FIRE_MANEUVER,
    xi.effect.ICE_MANEUVER,
    xi.effect.WIND_MANEUVER,
    xi.effect.EARTH_MANEUVER,
    xi.effect.THUNDER_MANEUVER,
    xi.effect.WATER_MANEUVER,
    xi.effect.LIGHT_MANEUVER,
    xi.effect.DARK_MANEUVER,
}

local function removeAllManeuvers(master)
    -- Era Eraser consumes all active maneuvers, not just Light Maneuvers.
    for _, maneuverId in ipairs(maneuvers) do
        for _ = 1, master:countEffect(maneuverId) do
            master:delStatusEffectSilent(maneuverId)
        end
    end
end

local removables =
{
    -- Songs
    xi.effect.ELEGY,
    xi.effect.REQUIEM,
    xi.effect.THRENODY,

    -- Enfeebling
    xi.effect.BLINDNESS,
    xi.effect.PARALYSIS,
    xi.effect.SILENCE,
    xi.effect.POISON,
    xi.effect.CURSE_I,
    xi.effect.CURSE_II,
    xi.effect.DISEASE,
    xi.effect.PLAGUE,
    xi.effect.WEIGHT,
    xi.effect.BIND,
    xi.effect.ADDLE,
    xi.effect.SLOW,
    xi.effect.PETRIFICATION,

    -- DoTs
    xi.effect.BIO,
    xi.effect.DIA,
    xi.effect.BURN,
    xi.effect.FROST,
    xi.effect.CHOKE,
    xi.effect.RASP,
    xi.effect.SHOCK,
    xi.effect.DROWN,

    -- Main Stat Downs
    xi.effect.STR_DOWN,
    xi.effect.DEX_DOWN,
    xi.effect.VIT_DOWN,
    xi.effect.AGI_DOWN,
    xi.effect.INT_DOWN,
    xi.effect.MND_DOWN,
    xi.effect.CHR_DOWN,

    -- Combat Stat Downs
    xi.effect.ACCURACY_DOWN,
    xi.effect.ATTACK_DOWN,
    xi.effect.EVASION_DOWN,
    xi.effect.DEFENSE_DOWN,

    -- Magic Stat Downs
    xi.effect.MAGIC_ACC_DOWN,
    xi.effect.MAGIC_ATK_DOWN,
    xi.effect.MAGIC_EVASION_DOWN,
    xi.effect.MAGIC_DEF_DOWN,

    -- HP/MP/TP Stat Downs
    xi.effect.MAX_TP_DOWN,
    xi.effect.MAX_MP_DOWN,
    xi.effect.MAX_HP_DOWN,
}

m:addOverride('xi.actions.abilities.pets.automaton.eraser.onAutomatonAbilityCheck', function(target, automaton, skill)
    return 0
end)

m:addOverride('xi.actions.abilities.pets.automaton.eraser.onAutomatonAbility', function(target, automaton, skill, master, action)
    automaton:addRecast(xi.recast.ABILITY, skill:getID(), 30)

    local lightManeuvers = xi.automaton.getManeuverCount(master, master:countEffect(xi.effect.LIGHT_MANEUVER))
    local effectsRemoved = 0

    for _, effectId in ipairs(removables) do
        if target:hasStatusEffect(effectId) then
            target:delStatusEffectSilent(effectId)
            effectsRemoved = effectsRemoved + 1

            if effectsRemoved >= lightManeuvers then
                break
            end
        end
    end

    removeAllManeuvers(master)
    master:updateAttachments()

    if effectsRemoved > 0 then
        skill:setMsg(xi.msg.basic.DISAPPEAR_NUM)
    else
        skill:setMsg(xi.msg.basic.USES)
    end

    return effectsRemoved
end)

-----------------------------------
-- Economizer - Changes Economizer to consume all Dark Maneuvers on activation. : https://wiki.ffo.jp/html/10435.html
-----------------------------------
local activationThresholds =
{
    [0] = 30,
    [1] = 40,
    [2] = 50,
    [3] = 60,
}

m:addOverride('xi.actions.abilities.pets.automaton.economizer.onEquip', function(pet)
    pet:addListener('AUTOMATON_ATTACHMENT_CHECK', 'ATTACHMENT_ECONOMIZER', function(automaton, target)
        -- If Economizer is still on cooldown, do nothing.
        if automaton:hasRecast(xi.recast.ABILITY, xi.mobSkill.ECONOMIZER_AUTOMATON) then
            return
        end

        local master = automaton:getMaster()

        if not master then
            return
        end

        local darkManeuvers = master:countEffect(xi.effect.DARK_MANEUVER)

        if darkManeuvers == 0 then
            return
        end

        local maxMP = automaton:getMaxMP()

        -- If this automaton has no MP, do nothing.
        if maxMP == 0 then
            return
        end

        local mpPercent = automaton:getMPP()
        local mpThreshold = activationThresholds[darkManeuvers] or 30

        -- If the automaton's MP is above the threshold, do nothing.
        if mpPercent > mpThreshold then
            return
        end

        automaton:useMobAbility(xi.mobSkill.ECONOMIZER_AUTOMATON, automaton)
    end)
end)

m:addOverride('xi.actions.abilities.pets.automaton.economizer.onAutomatonAbility', function(target, automaton, skill, master, action)
    automaton:addRecast(xi.recast.ABILITY, skill:getID(), 180)

    local darkManeuvers = master:countEffect(xi.effect.DARK_MANEUVER)
    local mpRecovered   = math.floor(automaton:getMaxMP() * 0.2 * darkManeuvers)

    for _ = 1, darkManeuvers do
        master:delStatusEffectSilent(xi.effect.DARK_MANEUVER)
    end

    master:updateAttachments()

    skill:setMsg(xi.msg.basic.SKILL_RECOVERS_MP)

    return automaton:addMP(mpRecovered)
end)

return m
