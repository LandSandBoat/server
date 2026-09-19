-----------------------------------
require('scripts/globals/spells/damage_spell')
-----------------------------------
xi = xi or {}
xi.magic = xi.magic or {}
-----------------------------------

-- Applies resistance for additional effects
function applyResistanceAddEffect(actor, target, element, bonusMacc)
    return xi.combat.magicHitRate.calculateResistRate(actor, target, { magicalElement = element, bonusMacc = bonusMacc })
end

function addBonusesAbility(caster, ele, target, dmg, params)
    local affinityBonus = xi.spells.damage.calculateElementalStaffBonus(caster, ele)
    dmg = math.floor(dmg * affinityBonus)

    local magicDefense = xi.combat.damage.magicalElementSDT(target, ele)
    dmg = math.floor(dmg * magicDefense)

    local dayWeatherBonus = xi.spells.damage.calculateDayAndWeather(caster, ele, false)
    dmg = math.floor(dmg * dayWeatherBonus)

    local mab = 1
    local mdefBarBonus = 0
    if
        ele >= xi.element.FIRE and
        ele <= xi.element.WATER and
        target:hasStatusEffect(xi.data.element.getAssociatedBarspellEffect(ele))
    then -- bar- spell magic defense bonus
        mdefBarBonus = target:getStatusEffect(xi.data.element.getAssociatedBarspellEffect(ele)):getSubPower()
    end

    if params ~= nil and params.bonusmab ~= nil and params.includemab then
        mab = (100 + caster:getMod(xi.mod.MATT) + params.bonusmab) / (100 + target:getMod(xi.mod.MDEF) + mdefBarBonus)
    elseif params == nil or (params ~= nil and params.includemab) then
        mab = (100 + caster:getMod(xi.mod.MATT)) / (100 + target:getMod(xi.mod.MDEF) + mdefBarBonus)
    end

    if mab < 0 then
        mab = 0
    end

    dmg = math.floor(dmg * mab)

    return dmg
end
