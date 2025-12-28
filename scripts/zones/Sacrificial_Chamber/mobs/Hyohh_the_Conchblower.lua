-----------------------------------
-- Area : Sacrificial Chamber
-- Mob  : Hyohh the Conchblower
-- BCNM : Amphibian Assault
-- Job  : Bard
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

local enfeebleTable =
{
    [1] = { xi.magic.spell.FOE_REQUIEM_V,     xi.effect.REQUIEM },
    [2] = { xi.magic.spell.BATTLEFIELD_ELEGY, xi.effect.ELEGY   },
    [3] = { xi.magic.spell.HORDE_LULLABY,     xi.effect.SLEEP_I },
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 4)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 4)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    -- Base song list
    local spellList =
    {
        xi.magic.spell.KNIGHTS_MINNE_IV,
        xi.magic.spell.VALOR_MINUET_IV,
        xi.magic.spell.VICTORY_MARCH,
        xi.magic.spell.ARMYS_PAEON_III,
    }

    -- Add enfeebles if they are missing from our target
    for i = 1, #enfeebleTable do
        if not target:hasStatusEffect(enfeebleTable[i][2]) then
            table.insert(spellList, enfeebleTable[i][1])
        end
    end

    -- Pick a random spell from the compiled list
    return spellList[math.random(1, #spellList)]
end

return entity
