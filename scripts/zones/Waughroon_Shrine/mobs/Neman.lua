-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Neman
-- BCNM: Birds of a Feather
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.CHARMABLE, 1)
end

entity.onMobMobskillChoose = function(mob, target)
    local skillList =
    {
        xi.mobSkill.HELLDIVE_1,
        xi.mobSkill.WING_CUTTER_1,
        xi.mobSkill.DAMNATION_DIVE_1,
        xi.mobSkill.BROADSIDE_BARRAGE_1,
        xi.mobSkill.BLIND_SIDE_BARRAGE_1,
    }
    return skillList[math.random(1, #skillList)]
end

return entity
