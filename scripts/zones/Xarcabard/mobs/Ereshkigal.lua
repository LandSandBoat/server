-----------------------------------
-- Area: Xarcabard
--   NM: Ereshkigal
-- Note: Works very similarly to Noble Mold spawn conditions
--       https://www.bg-wiki.com/ffxi/Ereshkigal
--       https://wiki.ffo.jp/html/12722.html
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onMobSpawn = function(mob)
    -- TODO any dmg absorb like Noble Mold?
    -- Confirmed it takes dmg from blizzard and water
    -- TODO any other immunities?
    -- confirmed it is not immune to Blind
    mob:addImmunity(xi.immunity.PARALYZE)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENDARK)
end

entity.onMobDeath = function(mob, player, optParams)
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
