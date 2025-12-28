-----------------------------------
-- Area: Grand Palace of HuXzoi
--  Mob: Ix'ghrah
-- Note: NM Ghrah that triggers a mob skill into a form shift every 60 seconds
--       Each form has a unique 2-hour ability
-----------------------------------
---@type TMobEntity
local entity = {}

local forms =
{
    BALL   = 0,
    HUMAN  = 1,
    SPIDER = 2,
    BIRD   = 3,
}

local formConfig =
{
-- [form]          = { mobskill, 2-hour, castingEnabled, damageMultiplier, delay, tripleAttack, attBonus, evaBonus, defBonus, defMultiplier }
    [forms.BALL  ] = { xi.mobSkill.HEXIDISCS,            xi.jsa.MANAFONT,       true,  2200, 100, 0,  0,  0,  0, 1 },
    [forms.HUMAN ] = { xi.mobSkill.VORPAL_BLADE_GHRAH,   xi.jsa.INVINCIBLE,     false, 2200, 100, 0,  0,  0, 60, 1 },
    [forms.SPIDER] = { xi.mobSkill.SICKLE_SLASH,         xi.jsa.MIGHTY_STRIKES, false, 2700, 200, 0, 11,  0, 11, 2 },
    [forms.BIRD  ] = { xi.mobSkill.DAMNATION_DIVE_GHRAH, xi.jsa.PERFECT_DODGE,  false, 1600, 100, 5,  0, 48,  0, 1 },
}

local function setupForm(mob, chosenForm)
    mob:setAnimationSub(chosenForm)
    mob:setMagicCastingEnabled(formConfig[chosenForm][3])
    mob:setDelay(formConfig[chosenForm][4])
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, formConfig[chosenForm][5])
    mob:setMod(xi.mod.TRIPLE_ATTACK, formConfig[chosenForm][6])
    mob:setMod(xi.mod.ATT, mob:getLocalVar('originalATT') + formConfig[chosenForm][7])
    mob:setMod(xi.mod.DEF, mob:getLocalVar('originalDEF') * formConfig[chosenForm][10] + formConfig[chosenForm][9])
    mob:setMod(xi.mod.EVA, mob:getLocalVar('originalEVA') + formConfig[chosenForm][8])
    mob:setLocalVar('changeTime', GetSystemTime() + 60)
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 30)
    mob:setMobMod(xi.mobMod.NO_SPELL_COST, 1)
    mob:setMod(xi.mod.MATT, 20)
    mob:setMod(xi.mod.MDEF, 20)
    mob:setMod(xi.mod.DMGMAGIC, -1250)
    mob:setMod(xi.mod.REGEN, 30)

    mob:setLocalVar('originalATT', mob:getMod(xi.mod.ATT))
    mob:setLocalVar('originalDEF', mob:getMod(xi.mod.DEF))
    mob:setLocalVar('originalEVA', mob:getMod(xi.mod.EVA))

    setupForm(mob, forms.BALL)
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    -- 2-hour logic.
    if mob:getHPP() <= 30 and mob:getLocalVar('twoHourUsed') == 0 then
        mob:useMobAbility(formConfig[mob:getAnimationSub()][2])
        mob:setLocalVar('twoHourUsed', 1)

        return
    end

    -- Check if it's time to switch forms (every 60 seconds)
    if GetSystemTime() > mob:getLocalVar('changeTime') then
        mob:useMobAbility(formConfig[mob:getAnimationSub()][1])
    end
end

entity.onMobMobskillChoose = function(mob, target)
    -- Only uses Actinic Burst when using TP normally
    return xi.mobSkill.ACTINIC_BURST
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local currentForm = mob:getAnimationSub()

    if skill:getID() == formConfig[currentForm][1] then
        local newForm = (currentForm + math.random(1, 3)) % 4
        setupForm(mob, newForm)
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellTable =
    {
        [xi.element.FIRE   ] = xi.magic.spell.FIRAGA_III,
        [xi.element.ICE    ] = xi.magic.spell.BLIZZAGA_III,
        [xi.element.WIND   ] = xi.magic.spell.AEROGA_III,
        [xi.element.EARTH  ] = xi.magic.spell.STONEGA_III,
        [xi.element.THUNDER] = xi.magic.spell.THUNDAGA_III,
        [xi.element.WATER  ] = xi.magic.spell.WATERGA_III,
        [xi.element.LIGHT  ] = xi.magic.spell.BANISHGA_III,
        [xi.element.DARK   ] = xi.magic.spell.SLEEPGA_II,
    }

    return spellTable[VanadielDayElement()]
end

return entity
