-----------------------------------
-- Spell: Pinecone Bomb
-- Additional effect: Sleep. Duration of effect varies with TP
-- Spell cost: 48 MP
-- Monster Type: Plantoids
-- Spell Type: Physical (Piercing)
-- Blue Magic Points: 2
-- Stat Bonus: STR+1
-- Level: 36
-- Casting Time: 2.5 seconds
-- Recast Time: 26.5 seconds
-- Skillchain Element(s): Liquefaction
-- Combos: None
-----------------------------------
require("scripts/globals/bluemagic")
require("scripts/globals/status")
require("scripts/globals/magic")
-----------------------------------
local spellObject = {}

<<<<<<< refs/remotes/upstream/base
local function inverseBellRand(min, max, weight)
    if not weight then
        weight = 0.5
    end

    local mid = math.floor((max - min) / 2)
    local rand = math.floor(mid * math.pow(math.random(), weight))
    if math.random() < 0.5 then
        return min + mid - rand
    else
        return min + mid + rand
    end
end

=======
>>>>>>> Azure Lore, potency/correlation merits, correlation in general, clean up, physical about done
spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local params = {}
    params.ecosystem = xi.ecosystem.PLANTOID
    params.tpmod = TPMOD_DURATION
    params.attackType = xi.attackType.RANGED
    params.damageType = xi.damageType.PIERCING
    params.scattr = SC_LIQUEFACTION
    params.attribute = xi.mod.INT
    params.skillType = xi.skill.BLUE_MAGIC
    params.numhits = 1
    params.multiplier = 2.25
    params.tp150 = 2.25
    params.tp300 = 2.25
    params.azuretp = 2.25
    params.duppercap = 37
    params.str_wsc = 0.2
    params.dex_wsc = 0.0
    params.vit_wsc = 0.0
    params.agi_wsc = 0.2
    params.int_wsc = 0.0
    params.mnd_wsc = 0.0
    params.chr_wsc = 0.0

    local damage = blueDoPhysicalSpell(caster, target, spell, params)
    damage = blueFinalizeDamage(caster, target, spell, damage, params)

    -- Added effect: Sleep (30s/60s)
    if damage > 0 then
        local resist = applyResistanceEffect(caster, target, spell, params)
        if resist >= 0.5 then
            target:addStatusEffect(xi.effect.SLEEP_I, 1, 0, 60 * resist)
        end
    end

    return damage
end

return spellObject
