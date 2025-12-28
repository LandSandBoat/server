-----------------------------------
-- Area : Sacrificial Chamber
-- Mob  : Sable-tongued Gonberry
-- BCNM : Jungle Boogymen
-- Job  : Black Mage
-----------------------------------
mixins =
{
    require('scripts/mixins/families/tonberry'),
    require('scripts/mixins/job_special')
}
-----------------------------------
---@type TMobEntity
local entity = {}

local enfeebleTable =
{
    [1] = { xi.magic.spell.BURN,        xi.effect.BURN      },
    [2] = { xi.magic.spell.SHOCK,       xi.effect.SHOCK     },
    [3] = { xi.magic.spell.CHOKE,       xi.effect.CHOKE     },
    [4] = { xi.magic.spell.BIO_II,      xi.effect.BIO       },
    [5] = { xi.magic.spell.POISONGA_II, xi.effect.POISON    },
    [6] = { xi.magic.spell.BLIND,       xi.effect.BLINDNESS },
    [7] = { xi.magic.spell.SLEEPGA,     xi.effect.SLEEP_I   },
    [8] = { xi.magic.spell.SLEEPGA_II,  xi.effect.SLEEP_I   },
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 8)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 4)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.AERO_III,
        xi.magic.spell.FIRE_III,
        xi.magic.spell.BLIZZARD_III,
        xi.magic.spell.BLIZZAGA_II,
        xi.magic.spell.THUNDAGA_II,
        xi.magic.spell.STONEGA_III,
        xi.magic.spell.BURST,
        xi.magic.spell.FLARE,
        xi.magic.spell.FLOOD,
        xi.magic.spell.DRAIN,
        xi.magic.spell.STUN,
    }

    if target:getMP() > 0 then
        table.insert(spellList, xi.magic.spell.ASPIR)
    end

    if not mob:hasStatusEffect(xi.effect.BLAZE_SPIKES) then
        table.insert(spellList, xi.magic.spell.BLAZE_SPIKES)
    end

    for i = 1, #enfeebleTable do
        if not target:hasStatusEffect(enfeebleTable[i][2]) then
            table.insert(spellList, enfeebleTable[i][1])
        end
    end

    return spellList[math.random(1, #spellList)]
end

return entity
