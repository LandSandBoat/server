-----------------------------------
-- Area: Balgas Dais
-- Mob: Dvorovoi
-- BCNM: Steamed Sprouts
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 60)
    mob:setMobMod(xi.mobMod.SUPERLINK, 1)
end

-- Dvorovoi uses Paralyga, Blindga, and Flood randomly as spells.
entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.PARALYGA,
        xi.magic.spell.BLINDGA,
        xi.magic.spell.FLOOD,
    }

    return spellList[math.random(1, #spellList)]
end

return entity
