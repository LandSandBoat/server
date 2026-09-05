-----------------------------------
-- Spell: 1000 Needles
-- Shoots multiple needles at enemies within range
-- Spell cost: 350 MP
-- Monster Type: Plantoid
-- Spell Type: Magical (Light)
-- Blue Magic Points: 5
-- Stat Bonus: VIT+3, AGI+3
-- Level: 62
-- Casting Time: 12 seconds
-- Recast Time: 120 seconds
-- Bursts on Light affects accuracy only
-- Combos: Beast Killer
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params          = xi.spells.blue.getDefaultParams(caster)
    params.ecosystem      = xi.ecosystem.PLANTOID
    params.tpModifier     = xi.spells.blue.tpMod.DAMAGE
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.LIGHT
    params.skillchainType = xi.skillchainType.COMPRESSION

    params.bonusMacc     = -50 -- 50 magic accuracy penalty
    params.numHits       = 1
    params.ftp0          = 1.5
    params.ftp1500       = 1.5
    params.ftp3000       = 1.5
    params.ftpAzure      = 1.5
    params.baseDamageCap = 49

    params.str_wsc = 1.0
    params.dex_wsc = 1.5
    params.int_wsc = 2.0
    params.mnd_wsc = 1.0
    params.chr_wsc = 1.0

    local damage = 1000
    local maccParams =
    {
        magicalElement = xi.element.LIGHT,
        actorStat      = xi.mod.INT,
        skillType      = xi.skill.BLUE_MAGIC,
        spellGroup     = spell:getSpellGroup(),
        bonusMacc      = -50
    }

    local resist = xi.combat.magicHitRate.calculateResistRate(caster, target, maccParams)
    if resist == 1 then
        local targets = spell:getTotalTargets()
        damage = damage / targets
        damage = xi.spells.blue.applySpellDamage(caster, target, spell, damage, params)
    else
        spell:setMsg(xi.msg.basic.MAGIC_RESIST)
    end

    return damage
end

return spellObject
