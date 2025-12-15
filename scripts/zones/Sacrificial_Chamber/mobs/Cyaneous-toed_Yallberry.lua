-----------------------------------
-- Area : Sacrificial Chamber
-- Mob  : Cyaneous-toed Yallberry
-- BCNM : Jungle Boogymen
-- Job  : Ninja
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
    [1] = { xi.magic.spell.DOKUMORI_NI, xi.effect.POISON    },
    [2] = { xi.magic.spell.KURAYAMI_NI, xi.effect.BLINDNESS },
    [3] = { xi.magic.spell.HOJO_NI,     xi.effect.SLOW      },
    [4] = { xi.magic.spell.JUBAKU_NI,   xi.effect.PARALYSIS },
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 8)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 4)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    -- Base Elemental Wheel
    local spellList =
    {
        xi.magic.spell.DOTON_NI,
        xi.magic.spell.HYOTON_NI,
        xi.magic.spell.HUTON_NI,
        xi.magic.spell.KATON_NI,
        xi.magic.spell.RAITON_NI,
        xi.magic.spell.SUITON_NI,
    }

    -- Add Utsusemi if we don't have it
    if not mob:hasStatusEffect(xi.effect.COPY_IMAGE) then
        table.insert(spellList, xi.magic.spell.UTSUSEMI_NI)
    end

    -- Add enfeebles if they are missing from our target
    for i = 1, #enfeebleTable do
        if not target:hasStatusEffect(enfeebleTable[i][2]) then
            table.insert(spellList, enfeebleTable[i][1])
        end
    end

    -- Return a random spell from the compiled list
    return spellList[math.random(#spellList)]
end

return entity
