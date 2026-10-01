-----------------------------------
-- Spell: Plenilune Embrace
-- Restores target party member's HP and enhances attack and magic attack.
-----------------------------------
---@type TSpell
local spellObject = {}

local cureTiers =
{
    old =
    {
        { powerFloor = 559, divisor = 2.8333, constant = 491.2 },
        { powerFloor = 319, divisor =      1, constant =   310 },
        { powerFloor =   0, divisor = 0.6666, constant =   230 },
    },
}

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

spellObject.onMagicCastingCheck = function(caster, target, spell)
    return 0
end

spellObject.onSpellCast = function(caster, target, spell)
    local duration = 90
    local moonBuff = cycleBuffs[getVanadielMoonCycle()]

    caster:addStatusEffect(xi.effect.ATTACK_BOOST, { power = moonBuff.atk, duration = duration, origin = caster })
    caster:addStatusEffect(xi.effect.MAGIC_ATK_BOOST, { power = moonBuff.mab, duration = duration, origin = caster })

    local params =
    {
        baseCure  = xi.combat.action.calculateSpellCureBase(caster, cureTiers),
        minCure   = 350,
        skillType = xi.skill.BLUE_MAGIC,
    }

    return xi.combat.action.executeSpellCure(caster, target, spell, params)
end

return spellObject
