-----------------------------------
-- Area : Throne Room
-- Mob  : Count Andromalius
-- BCNM : Kindred Spirits
-- Job  : Dark Knight
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 6)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 7)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.THUNDER,
        xi.magic.spell.BLIZZARD,
        xi.magic.spell.ABSORB_TP,
        xi.magic.spell.DRAIN,
    }

    if target:getMP() > 0 then
        table.insert(spellList, xi.magic.spell.ASPIR)
    end

    if not target:hasStatusEffect(xi.effect.STUN) then
        table.insert(spellList, xi.magic.spell.STUN)
    end

    return spellList[math.random(1, #spellList)]
end

return entity
