-----------------------------------
-- Area: The Sanctuary of Zi'Tah
--  Mob: Noble Mold
-- Note: Special spawn conditions from a particular Myxonycete. Doesn't despawn on weather change, doesn't appear to have anything special
--       Absorbs water damage and appears to only casts Water-Elemental spells
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    -- TODO any immunities at all? The below were the only ones tried
    -- not immune: bind, dispel, poison, addle, silence, paralyze, slow
    mob:setMod(xi.mod.WATER_ABSORB, 100)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 115, 1, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 116, 2, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    -- set PH back to active spawn
    local ph = GetMobByID(mob:getID() - 1)
    if ph then
        DisallowRespawn(ph:getID(), false)
        ph:setRespawnTime(ph:getRespawnTime())
    end
end

return entity
