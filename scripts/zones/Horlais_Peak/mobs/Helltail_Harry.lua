-----------------------------------
-- Area: Horlais Peak
--  Mob: Helltail Harry
-- BCNM: Tails of Woe
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 4)
    mob:setMod(xi.mod.SILENCE_RES_RANK, 7)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 60)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.BLIZZARD_II,
        xi.magic.spell.SLOWGA,
        xi.magic.spell.HASTEGA,
    }

    return spellList[math.random(1, #spellList)]
end

return entity
