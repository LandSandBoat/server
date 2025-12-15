-----------------------------------
-- Spell: Plenilune Embrace
-- Restores target party member's HP and enhances attack and magic attack..
-- Shamelessly stolen from http://members.shaw.ca/pizza_steve/cure/Cure_Calculator.html
-----------------------------------
require('scripts/globals/magic')
-----------------------------------
---@type TSpell
local spellObject = {}

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local duration = 90
    local moonCycle = getVanadielMoonCycle()

    local cycleBuffs =
    {
        [xi.moonCycle.NEW_MOON]                = { atk = 1,  mab = 15 },
        [xi.moonCycle.LESSER_WAXING_CRESCENT]  = { atk = 3,  mab = 12 },
        [xi.moonCycle.GREATER_WAXING_CRESCENT] = { atk = 5,  mab = 10 },
        [xi.moonCycle.FIRST_QUARTER]           = { atk = 7,  mab = 7  },
        [xi.moonCycle.LESSER_WAXING_GIBBOUS]   = { atk = 10, mab = 5  },
        [xi.moonCycle.GREATER_WAXING_GIBBOUS]  = { atk = 12, mab = 3  },
        [xi.moonCycle.FULL_MOON]               = { atk = 15, mab = 1  },
        [xi.moonCycle.GREATER_WANING_GIBBOUS]  = { atk = 12, mab = 3  },
        [xi.moonCycle.LESSER_WANING_GIBBOUS]   = { atk = 10, mab = 5  },
        [xi.moonCycle.THIRD_QUARTER]           = { atk = 7,  mab = 7  },
        [xi.moonCycle.GREATER_WANING_CRESCENT] = { atk = 5,  mab = 10 },
        [xi.moonCycle.LESSER_WANING_CRESCENT]  = { atk = 3,  mab = 12 },
    }

    local moonBuff = cycleBuffs[moonCycle]
    local atkBoost = moonBuff.atk
    local mabBoost = moonBuff.mab

    caster:addStatusEffect(xi.effect.ATTACK_BOOST, atkBoost, 0, duration)
    caster:addStatusEffect(xi.effect.MAGIC_ATK_BOOST, mabBoost, 0, duration)

    local minCure = 350

    local divisor = 0.6666
    local constant = 230
    local power = getCurePowerOld(caster)
    if power > 559 then
        divisor = 2.8333
        constant = 491.2
    elseif power > 319 then
        divisor =  1
        constant = 310
    end

    local final = getCureFinal(caster, spell, getBaseCureOld(power, divisor, constant), minCure, true)

    final = final + (final * (target:getMod(xi.mod.CURE_POTENCY_RCVD) / 100))
    local diff = (target:getMaxHP() - target:getHP())
    if final > diff then
        final = diff
    end

    target:addHP(final)
    caster:updateEnmityFromCure(target, final)
    return final
end

return spellObject
