-----------------------------------
-- Area: Balga's Dais
--  Mob: Pepper
-- BCNM: Charming Trio
-----------------------------------
---@type TMobEntity
local entity = {}

-- https://docs.google.com/spreadsheets/d/1TnrBzUAQ0hyuFVIjf5OLviIfhGw4vxN1x_4zv9gG4N4/edit?pli=1&gid=368168805#gid=368168805
entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)

    mob:setMobMod(xi.mobMod.MAGIC_COOL, 15)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, math.random(10, 12))
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15) -- 15' aggro range
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.DRAIN,
        xi.magic.spell.ASPIR,
    }

    return spellList[math.random(1, #spellList)]
end

return entity
