-----------------------------------
-- Area: Misareaux Coast
--  Mob: Bloody Coffin
--  Quest: The Call of the Sea
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.DOUBLE_ATTACK, 75)
end

entity.onMobFight = function(mob, target)
    if mob:getCurrentAction() == xi.act.MAGIC_CASTING or mob:getCurrentAction() == xi.act.MOBABILITY_START then
        mob:setMod(xi.mod.UDMGPHYS, 0)
        mob:setMod(xi.mod.UDMGMAGIC, 0)
        mob:setMod(xi.mod.UDMGRANGE, 0)
        mob:setUnkillable(false)
    else
        mob:setMod(xi.mod.UDMGPHYS, -7500)
        mob:setMod(xi.mod.UDMGMAGIC, -7500)
        mob:setMod(xi.mod.UDMGRANGE, -7500)
        mob:setUnkillable(true)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
