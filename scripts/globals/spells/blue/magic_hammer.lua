-----------------------------------
-- Spell: Magic Hammer
-- Steals an amount of enemy's MP equal to damage dealt. Ineffective against undead.
-- Spell cost: 40 MP
-- Monster Type: Beastmen
-- Spell Type: Magical (Light)
-- Blue Magic Points: 4
-- Stat Bonus: MP-5, MND+2
-- Level: 74
-- Casting Time: 4 seconds
-- Recast Time: 180 seconds
-- Magic Bursts on: Transfixion, Fusion, and Light
-- Combos: Magic Attack Bonus
-- Notes:
-- Modifiers: MND 30%.
-- Affected by Magic Attack Bonus.
-- The bonus from Light Staff/Apollo's Staff affects both accuracy and amount of MP drained.
-- The bonuses from weather/day effects and Korin/Hachirin-no-Obi affect both accuracy and amount of MP drained.
-- Can only drain MP from targets that have MP and cannot drain more MP than the target has.
-- Damage and MP drained are enhanced by both Magic Attack Bonus and Magic Attack from Convergence.
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.BEASTMEN
    params.attackType = xi.attackType.MAGICAL
    params.damageType = xi.damageType.LIGHT
    params.attribute = xi.mod.MND
    params.multiplier = 1.5
    params.azureBonus = 0.5
    params.tMultiplier = 1.0
    params.duppercap = 35
    params.str_wsc = 0.0
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.0
    params.int_wsc = 0.0
    params.mnd_wsc = 0.3
    params.chr_wsc = 0.0

    local damage = 0
    if target:isUndead() then
        spell:setMsg(xi.msg.basic.MAGIC_NO_EFFECT)
    else
<<<<<<< refs/remotes/upstream/base
<<<<<<< refs/remotes/upstream/base
        dmg = blueDoMagicalSpell(caster, target, spell, params, MND_BASED)
        dmg = blueFinalizeDamage(caster, target, spell, dmg, params)
        if target:getMP() > 0 then
            if target:getMP() < dmg then
                dmg = target:getMP()
            end

            caster:addMP(dmg)
        else
            return 0
        end
=======
        damage = blueDoMagicalSpell(caster, target, spell, params)
        damage = blueFinalizeDamage(caster, target, spell, damage, params)
<<<<<<< refs/remotes/upstream/base
        caster:addMP(utils.clamp(damage,0,target:getMP()))
>>>>>>> Enfeebling diff/attribute fixes + general magic damage function + almost all magical dmg spells + AE
    end

    -- weirdly this spell returns MP dmg message even if nothing's here wtf
=======
>>>>>>> Blue magic lock + 1000 needles/magic hammer/self-destruct
=======
        damage = bluDoMagicalSpell(caster, target, spell, params)
        damage = bluFinalizeDamage(caster, target, spell, damage, params)
>>>>>>> Healing spells + global blu functions name change

        local mpDrained = utils.clamp(damage, 0, target:getMP())
        if mpDrained == 0 then
            spell:setMsg(xi.msg.basic.MAGIC_DMG)
        else
            damage = mpDrained
            caster:addMP(damage)
            target:delMP(damage)
            spell:setMsg(xi.msg.basic.MAGIC_DRAIN_MP)
        end
    end
    
    return damage
end

return spellObject
