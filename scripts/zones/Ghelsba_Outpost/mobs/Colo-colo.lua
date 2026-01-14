-----------------------------------
-- Area: Ghelsba Outpost
--  Mob: Colo-colo
-- BCNM: Wings of Fury
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 25)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.DRAIN,
        xi.magic.spell.POISONGA,
    }

    return spellList[math.random(1, #spellList)]
end

return entity
