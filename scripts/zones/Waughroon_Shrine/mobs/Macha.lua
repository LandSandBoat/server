-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Macha
-- BCNM: Birds of a Feather
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.DISPELGA,
        xi.magic.spell.SLEEP,
    }

    return spellList[math.random(1, #spellList)]
end

entity.onMobMobskillChoose = function(mob, target)
    local skillList =
    {
        xi.mobSkill.HELLDIVE_1,
        xi.mobSkill.DAMNATION_DIVE_1,
        xi.mobSkill.BROADSIDE_BARRAGE_1,
        xi.mobSkill.BLIND_SIDE_BARRAGE_1,
    }
    return skillList[math.random(1, #skillList)]
end

return entity
