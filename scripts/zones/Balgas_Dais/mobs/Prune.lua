-----------------------------------
-- Area: Balga's Dais
--  Mob: Prune
-- BCNM: Charming Trio
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mobMod.CHARMABLE, 0)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onSpellPrecast = function(mob, spell)
    if spell:getID() == 245 then -- Drain CD
        mob:setMobMod(xi.mobMod.MAGIC_COOL, 45)
    else -- Aspir CD
        mob:setMobMod(xi.mobMod.MAGIC_COOL, 15)
    end
end

return entity
